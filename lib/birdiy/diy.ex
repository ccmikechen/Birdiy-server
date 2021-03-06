defmodule Birdiy.Diy do
  @moduledoc """
  The Diy context.
  """

  import Ecto.Changeset, only: [change: 2]
  import Ecto.Query, warn: false
  import Ecto.SoftDelete.Query

  alias Ecto.Multi
  alias Birdiy.Repo

  alias Birdiy.ProjectPhoto
  alias Birdiy.ProjectFile

  alias Birdiy.Diy.{
    ProjectCategory,
    ProjectTopic,
    Project,
    ProjectMaterial,
    ProjectFileResource,
    ProjectMethod,
    ProjectComment
  }

  alias Birdiy.Accounts
  alias Birdiy.Accounts.User
  alias Birdiy.Timeline.Activity

  def list_project_categories do
    Repo.all(ProjectCategory)
  end

  def project_from_global_id(global_id) do
    case Absinthe.Relay.Node.from_global_id(global_id, BirdiyWeb.Schema) do
      {:ok, %{id: id, type: :project}} ->
        {:ok, Repo.get(Project, id)}

      {:error, error} ->
        {:error, error}
    end
  end

  def project_categories_query(args) do
    Enum.reduce(args, ProjectCategory, fn
      {:order, order}, query ->
        query |> order_by(asc: ^order)

      _, query ->
        query
    end)
  end

  def get_project_category!(id), do: Repo.get!(ProjectCategory, id)

  def get_project_category_by_name!(nil), do: nil
  def get_project_category_by_name!(name), do: Repo.get_by!(ProjectCategory, name: name)

  def get_project_category_by_name(name), do: Repo.get_by(ProjectCategory, name: name)

  def create_project_category(attrs \\ %{}) do
    %ProjectCategory{}
    |> ProjectCategory.changeset(attrs)
    |> Repo.insert()
  end

  def list_project_topics do
    Repo.all(ProjectTopic)
  end

  def project_topics_query(args), do: project_topics_query(ProjectTopic, args)

  def project_topics_query(topics_query, args) do
    Enum.reduce(args, topics_query, fn
      {:order, order}, query ->
        query |> order_by(asc: ^order)

      _, query ->
        query
    end)
  end

  def get_project_topic!(id), do: Repo.get!(ProjectTopic, id)

  def get_project_topic_by_name(nil), do: nil
  def get_project_topic_by_name(name), do: Repo.get_by(ProjectTopic, name: name)

  def create_project_topic(attrs \\ %{}) do
    %ProjectTopic{}
    |> ProjectTopic.changeset(attrs)
    |> Repo.insert()
  end

  def list_projects do
    Project |> with_undeleted() |> Repo.all()
  end

  def projects_query(args), do: projects_query(Project, args)

  def projects_query(query, args) do
    Enum.reduce(args, query, fn
      {:order, :newest}, query ->
        query |> order_by(desc: :inserted_at)

      {:order, :hotest}, query ->
        query |> order_by(desc: :view_count)

      {:filter, filter}, query ->
        query |> project_filter_with(filter)

      {:published, true}, query ->
        from(q in query, where: not is_nil(q.published_at))

      {:published, false}, query ->
        from(q in query, where: is_nil(q.published_at))

      _, query ->
        query
    end)
    |> with_undeleted()
  end

  defp project_filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from(q in query, where: ilike(q.name, ^"%#{name}%"))

      {:topics, []}, query ->
        query

      {:topics, topics}, query ->
        from(q in query,
          join: t in assoc(q, :topic),
          where: t.name in ^topics
        )

      {:categories, []}, query ->
        query

      {:categories, categories}, query ->
        from(q in query,
          join: t in assoc(q, :topic),
          join: c in assoc(t, :category),
          where: c.name in ^categories
        )
    end)
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def get_project_materials!(%Project{} = project) do
    Ecto.assoc(project, :materials)
    |> order_by(:order)
    |> Repo.all()
  end

  def file_url(%ProjectFileResource{} = file) do
    ProjectFile.url_from(file)
  end

  def get_project_file_resources!(%Project{} = project) do
    Ecto.assoc(project, :file_resources)
    |> order_by(:order)
    |> Repo.all()
  end

  def get_project_methods!(%Project{} = project) do
    Ecto.assoc(project, :methods)
    |> order_by(:order)
    |> Repo.all()
  end

  def count_project_related_posts!(%Project{} = project) do
    Ecto.assoc(project, :related_posts)
    |> Repo.aggregate(:count, :id)
  end

  def count_project_favorites!(%Project{} = project) do
    Ecto.assoc(project, :favorite_users)
    |> Repo.aggregate(:count, :id)
  end

  def count_project_likes!(%Project{} = project) do
    Ecto.assoc(project, :liked_users)
    |> Repo.aggregate(:count, :id)
  end

  def create_project(%User{} = author, attrs \\ %{}) do
    cond do
      Accounts.count_user_projects!(author, false) < 3 ->
        %Project{author: author}
        |> Project.draft_changeset(attrs)
        |> Repo.insert()

      true ->
        {:error, "Reached maximum 3 drafts"}
    end
  end

  def project_image_url(%Project{} = project) do
    ProjectPhoto.url_from(project)
  end

  def update_project(%Project{} = project, %User{} = author, attrs) do
    project = Repo.preload(project, [:topic, :materials, :file_resources, :methods])

    result =
      Multi.new()
      |> update_project_query(project, author, attrs)
      |> Repo.transaction()

    case result do
      {:ok, %{update_project: project}} ->
        {:ok, project}

      _ ->
        nil
    end
  end

  defp update_project_query(multi, %Project{} = project, %User{} = author, attrs) do
    attrs = Map.merge(attrs, %{author: author})
    update_project_query(multi, project, attrs)
  end

  defp update_project_query(multi, %Project{} = project, attrs) do
    changeset = Project.changeset(project, attrs)
    Multi.update(multi, :update_project, changeset)
  end

  def publish_project(%Project{} = project) do
    Multi.new()
    |> publish_project_query(project)
    |> upsert_project_activity_query(project)
    |> Repo.transaction()
    |> case do
      {:ok, %{publish_project: project}} ->
        {:ok, project}

      _ ->
        nil
    end
  end

  defp publish_project_query(multi, %Project{} = project) do
    changeset = Project.publish_changeset(project)
    Multi.update(multi, :publish_project, changeset)
  end

  def increase_project_view_count(%Project{} = project) do
    increase_project_view_count(project.id)
  end

  def increase_project_view_count(project_id) do
    from(p in Project,
      where: p.id == ^project_id,
      where: not is_nil(p.published_at)
    )
    |> Repo.update_all(inc: [view_count: 1])
  end

  def increase_project_report_count(%Project{} = project) do
    increase_project_report_count(project.id)
  end

  def increase_project_report_count(project_id) do
    from(p in Project, where: p.id == ^project_id)
    |> Repo.update_all(inc: [report_count: 1])
  end

  defp upsert_project_activity_query(multi, project) do
    changeset = Activity.changeset(%Activity{}, %{project_id: project.id})
    Multi.insert(multi, :upsert_project_activity, changeset, on_conflict: :nothing)
  end

  def unpublish_project(%Project{} = project) do
    change(project, published_at: nil) |> Repo.update()
  end

  def delete_project(%Project{} = project) do
    Repo.soft_delete(project)
  end

  def get_project_material!(id), do: Repo.get!(ProjectMaterial, id)

  def get_project_file_resource!(id), do: Repo.get!(ProjectFileResource, id)

  def get_project_method!(id), do: Repo.get!(ProjectMethod, id)

  def project_method_image_url(%ProjectMethod{} = method) do
    ProjectPhoto.url_from(method)
  end

  def list_project_comments do
    Repo.all(ProjectComment)
  end

  def project_comments_query(args), do: project_comments_query(ProjectComment, args)

  def project_comments_query(query, args) do
    Enum.reduce(args, query, fn
      {:order, order}, query ->
        query |> order_by(desc: ^order)

      _, query ->
        query
    end)
  end

  def get_project_comment!(id), do: Repo.get!(ProjectComment, id)

  def create_project_comment(%User{} = user, attrs \\ %{}) do
    %ProjectComment{user: user}
    |> ProjectComment.changeset(attrs)
    |> Repo.insert()
  end

  def update_project_comment(%ProjectComment{} = project_comment, attrs) do
    project_comment
    |> ProjectComment.changeset(attrs)
    |> Repo.update()
  end

  def delete_project_comment(%ProjectComment{} = project_comment) do
    Repo.delete(project_comment)
  end

  def change_project_comment(%ProjectComment{} = project_comment) do
    ProjectComment.changeset(project_comment, %{})
  end

  def increase_project_comment_report_count(%ProjectComment{} = project_comment) do
    increase_project_comment_report_count(project_comment.id)
  end

  def increase_project_comment_report_count(project_comment_id) do
    from(p in ProjectComment, where: p.id == ^project_comment_id)
    |> Repo.update_all(inc: [report_count: 1])
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
