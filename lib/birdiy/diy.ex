defmodule Birdiy.Diy do
  @moduledoc """
  The Diy context.
  """

  import Ecto.Changeset, only: [change: 2]
  import Ecto.Query, warn: false
  import Ecto.SoftDelete.Query

  alias Ecto.Multi
  alias Birdiy.Repo
  alias Birdiy.Helpers

  alias Birdiy.Diy.{
    ProjectCategory,
    Project,
    ProjectMaterial,
    ProjectFileResource,
    ProjectMethod
  }

  alias Birdiy.Accounts.User

  def list_project_categories do
    Repo.all(ProjectCategory)
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

  def create_project_category(attrs \\ %{}) do
    %ProjectCategory{}
    |> ProjectCategory.changeset(attrs)
    |> Repo.insert()
  end

  def list_projects do
    Repo.all(Project) |> with_undeleted()
  end

  def projects_query(args), do: projects_query(Project, args)

  def projects_query(query, args) do
    Enum.reduce(args, query, fn
      {:order, :newest}, query ->
        query |> order_by(desc: :inserted_at)

      {:filter, filter}, query ->
        query |> project_filter_with(filter)

      _, query ->
        query
    end)
    |> with_undeleted()
  end

  defp project_filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from(q in query, where: ilike(q.name, ^"%#{name}%"))

      {:categories, []}, query ->
        query

      {:categories, categories}, query ->
        from(q in query,
          join: c in assoc(q, :category),
          where: c.name in ^categories
        )

      {:published, true}, query ->
        from(q in query, where: not is_nil(q.published_at))

      {:published, false}, query ->
        from(q in query, where: is_nil(q.published_at))
    end)
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def get_project_materials!(%Project{} = project) do
    Ecto.assoc(project, :materials)
    |> order_by(:order)
    |> Repo.all()
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

  def count_project_views!(%Project{} = project) do
    Ecto.assoc(project, :viewed_users)
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
    %Project{}
    |> Project.draft_changeset(author, attrs)
    |> Repo.insert()
  end

  def update_project(%Project{} = project, %User{} = author, attrs) do
    result =
      Multi.new()
      |> upsert_project_materials_query(project, attrs[:materials])
      |> upsert_project_file_resources_query(project, attrs[:file_resources])
      |> upsert_project_methods_query(project, attrs[:methods])
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
    if is_nil(project.published_at) do
      changeset = Project.changeset(project, author, attrs)
      Multi.update(multi, :update_project, changeset)
    else
      update_published_project_query(multi, project, author, attrs)
    end
  end

  defp update_published_project_query(multi, %Project{} = project, %User{} = author, attrs) do
    Multi.run(multi, :update_project, fn _, _ ->
      Project.publish_changeset(project, author, attrs) |> Repo.update()
    end)
  end

  def publish_project(%Project{} = project, %User{} = author) do
    case project_publishable?(project, author) do
      true -> change(project, published_at: Helpers.DateTime.utc_now()) |> Repo.update()
      _ -> :error
    end
  end

  defp project_publishable?(%Project{} = project, %User{} = author) do
    Project.publish_changeset(project, author, %{}).valid?()
  end

  def unpublish_project(%Project{} = project) do
    change(project, published_at: nil) |> Repo.update()
  end

  def delete_project(%Project{} = project) do
    Repo.soft_delete(project)
  end

  def get_project_material!(id), do: Repo.get!(ProjectMaterial, id)

  defp upsert_project_materials_query(multi, %Project{} = project, params) do
    ids = params |> Enum.map(& &1[:id]) |> Enum.reject(&is_nil/1)
    multi = delete_project_items_not_in_list_query(multi, project, :materials, ids)

    params
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {attrs, index}, multi ->
      attrs = Map.merge(attrs, %{project_id: project.id})

      changeset =
        case attrs[:id] && get_project_material!(attrs[:id]) do
          nil -> %ProjectMaterial{}
          material -> material
        end
        |> ProjectMaterial.changeset(attrs)

      Multi.insert_or_update(
        multi,
        "upsert_project_material_#{index}",
        changeset
      )
    end)
  end

  def get_project_file_resource!(id), do: Repo.get!(ProjectFileResource, id)

  defp upsert_project_file_resources_query(multi, %Project{} = project, params) do
    ids = params |> Enum.map(& &1[:id]) |> Enum.reject(&is_nil/1)
    multi = delete_project_items_not_in_list_query(multi, project, :file_resources, ids)

    params
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {attrs, index}, multi ->
      attrs = Map.merge(attrs, %{project_id: project.id})

      changeset =
        case attrs[:id] && get_project_file_resource!(attrs[:id]) do
          nil -> %ProjectFileResource{}
          file_resource -> file_resource
        end
        |> ProjectFileResource.changeset(attrs)

      Multi.insert_or_update(
        multi,
        "upsert_project_file_resource_#{index}",
        changeset
      )
    end)
  end

  def get_project_method!(id), do: Repo.get!(ProjectMethod, id)

  defp upsert_project_methods_query(multi, %Project{} = project, params) do
    ids = params |> Enum.map(& &1[:id]) |> Enum.reject(&is_nil/1)
    multi = delete_project_items_not_in_list_query(multi, project, :methods, ids)

    params
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {attrs, index}, multi ->
      attrs = Map.merge(attrs, %{project_id: project.id})

      changeset =
        case attrs[:id] && get_project_method!(attrs[:id]) do
          nil -> %ProjectMethod{}
          method -> method
        end
        |> ProjectMethod.changeset(attrs)

      Multi.insert_or_update(
        multi,
        "upsert_project_method_#{index}",
        changeset
      )
    end)
  end

  defp delete_project_items_not_in_list_query(multi, %Project{} = project, item, ids) do
    delete_query =
      Ecto.assoc(project, item)
      |> where([m], m.id not in ^ids)

    Helpers.Multi.soft_delete_all(
      multi,
      "delete_" <> Atom.to_string(item),
      delete_query
    )
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
