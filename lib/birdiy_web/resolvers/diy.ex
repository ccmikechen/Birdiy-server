defmodule BirdiyWeb.Resolvers.Diy do
  import Absinthe.Resolution.Helpers

  alias Absinthe.Relay.Connection
  alias Birdiy.{Repo, Diy, Accounts, ProjectFile}
  alias BirdiyWeb.Schema.Helpers
  alias BirdiyWeb.Errors

  def project_categories(pagination_args, _) do
    Connection.from_query(
      Diy.project_categories_query(pagination_args),
      &Repo.all/1,
      pagination_args
    )
  end

  def projects(%Diy.ProjectTopic{} = topic, pagination_args, _) do
    new_args = Map.put(pagination_args, :filter, %{topics: [topic.name]})
    projects(nil, new_args, nil)
  end

  def projects(%Diy.ProjectCategory{} = category, pagination_args, _) do
    new_args = Map.put(pagination_args, :filter, %{categories: [category.name]})
    projects(nil, new_args, nil)
  end

  def projects(_, pagination_args, _) do
    args = Map.put(pagination_args, :published, true)

    Connection.from_query(
      Diy.projects_query(args),
      &Repo.all/1,
      pagination_args
    )
  end

  def project(_, %{id: id}, %{context: %{loader: loader, remote_ip: ip}}) do
    loader
    |> Dataloader.load(Diy, Diy.Project, id)
    |> on_load(fn loader ->
      increase_project_view_count(ip, id)
      {:ok, Dataloader.get(loader, Diy, Diy.Project, id)}
    end)
  end

  defp increase_project_view_count(ip, project_id) do
    if !ConCache.get(:project_view, {ip, project_id}) do
      Diy.increase_project_view_count(project_id)
      ConCache.put(:project_view, {ip, project_id}, true)
    end
  end

  def create_project(_, %{input: params}, %{context: %{current_user: current_user}}) do
    case Diy.create_project(current_user, params) do
      {:ok, project} ->
        {:ok, %{project: project}}

      _ ->
        Errors.too_many_drafts()
    end
  end

  def edit_project(_, %{input: params}, %{context: %{current_user: current_user}}) do
    case Diy.update_project(params[:project], current_user, params) do
      {:ok, project} ->
        {:ok, %{project: project}}

      _ ->
        Errors.update_project()
    end
  end

  def edit_and_publish_project(_, %{input: params}, %{context: %{current_user: current_user}}) do
    with {:ok, project} <- Diy.update_project(params[:project], current_user, params),
         {:ok, project} <- Diy.publish_project(project) do
      {:ok, %{project: project}}
    else
      _ ->
        Errors.update_project()
    end
  end

  def delete_project(_, %{input: %{project: project}}, _) do
    case Diy.delete_project(project) do
      {:ok, project} ->
        {:ok, %{project: project}}

      _ ->
        Errors.delete_project()
    end
  end

  def publish_project(_, %{input: %{project: project}}, _) do
    case Diy.publish_project(project) do
      {:ok, project} ->
        {:ok, %{project: project}}

      _ ->
        Errors.publish_project()
    end
  end

  def unpublish_project(_, %{input: %{project: project}}, _) do
    case Diy.unpublish_project(project) do
      {:ok, project} ->
        {:ok, %{project: project}}

      _ ->
        Errors.unpublish_project()
    end
  end

  def report_project(_, %{input: %{id: project_id}}, _) do
    case Diy.increase_project_report_count(project_id) do
      {1, nil} -> {:ok, %{reported: true}}
      _ -> {:ok, %{reported: false}}
    end
  end

  def project_published(project, _, _) do
    {:ok, !is_nil(project.published_at)}
  end

  def project_viewed(project, _, %{context: %{current_user: current_user}}) do
    case Accounts.get_user_viewed_project(current_user.id, project.id) do
      %Accounts.UserViewedProject{} -> {:ok, true}
      _ -> {:ok, false}
    end
  end

  def project_viewed(_, _, _) do
    {:ok, false}
  end

  def project_liked(project, _, %{context: %{current_user: current_user}}) do
    case Accounts.get_user_liked_project(current_user.id, project.id) do
      %Accounts.UserLikedProject{} -> {:ok, true}
      _ -> {:ok, false}
    end
  end

  def project_liked(_, _, _) do
    {:ok, false}
  end

  def project_favorite(project, _, %{context: %{current_user: current_user}}) do
    case Accounts.get_user_favorite_project(current_user.id, project.id) do
      %Accounts.UserFavoriteProject{} -> {:ok, true}
      _ -> {:ok, false}
    end
  end

  def project_favorite(_, _, _) do
    {:ok, false}
  end

  def project_author(project, _, _) do
    Helpers.batch_by_id(Accounts.User, project.author_id)
  end

  def project_topic(project, _, _) do
    Helpers.batch_by_id(Diy.ProjectTopic, project.topic_id)
  end

  def topics_for_category(category, pagination_args, _) do
    Ecto.assoc(category, :topics)
    |> Diy.project_topics_query(pagination_args)
    |> Connection.from_query(&Repo.all/1, pagination_args)
  end

  def topic_category(topic, _, _) do
    Helpers.batch_by_id(Diy.ProjectCategory, topic.category_id)
  end

  def material_project(material, _, _) do
    Helpers.batch_by_id(Diy.Project, material.project_id)
  end

  def materials_for_project(project, _, _) do
    {:ok, Diy.get_project_materials!(project)}
  end

  def file_resource_project(file_resource, _, _) do
    Helpers.batch_by_id(Diy.Project, file_resource.project_id)
  end

  def file_resources_for_project(project, _, _) do
    {:ok, Diy.get_project_file_resources!(project)}
  end

  def file_resource_url(file_resource, _, _) do
    case file_resource.file do
      nil ->
        {:ok, file_resource.url}

      _ ->
        {:ok, ProjectFile.url({file_resource.file, file_resource})}
    end
  end

  def file_resource_type(file_resource, _, _) do
    case file_resource.file do
      nil -> {:ok, "link"}
      _ -> {:ok, "file"}
    end
  end

  def method_project(method, _, _) do
    Helpers.batch_by_id(Diy.Project, method.project_id)
  end

  def methods_for_project(project, _, _) do
    {:ok, Diy.get_project_methods!(project)}
  end

  def related_posts_for_project(pagination_args, %{source: project}) do
    Ecto.assoc(project, :related_posts)
    |> Connection.from_query(&Repo.all/1, pagination_args)
  end

  def comments_for_project(project, pagination_args, _) do
    Ecto.assoc(project, :comments)
    |> Diy.project_comments_query(pagination_args)
    |> Connection.from_query(&Repo.all/1, pagination_args)
  end

  def project_related_post_count(project, _, _) do
    {:ok, Diy.count_project_related_posts!(project)}
  end

  def project_favorite_count(project, _, _) do
    {:ok, Diy.count_project_favorites!(project)}
  end

  def project_like_count(project, _, _) do
    {:ok, Diy.count_project_likes!(project)}
  end

  def project_comment(_, %{id: id}, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Diy, Diy.ProjectComment, id)
    |> on_load(fn loader ->
      {:ok, Dataloader.get(loader, Diy, Diy.ProjectComment, id)}
    end)
  end

  def create_project_comment(_, %{input: params}, %{context: %{current_user: current_user}}) do
    case Diy.create_project_comment(current_user, params) do
      {:ok, project_comment} ->
        {:ok, %{project_comment: project_comment}}

      _ ->
        Errors.create_project_comment()
    end
  end

  def edit_project_comment(_, %{input: params}, _) do
    case Diy.update_project_comment(params[:project_comment], params) do
      {:ok, project_comment} ->
        {:ok, %{project_comment: project_comment}}

      _ ->
        Errors.update_project_comment()
    end
  end

  def delete_project_comment(_, %{input: params}, _) do
    case Diy.delete_project_comment(params[:project_comment]) do
      {:ok, project_comment} ->
        {:ok, %{project_comment: project_comment}}

      _ ->
        Errors.delete_project_comment()
    end
  end

  def report_project_comment(_, %{input: %{id: project_comment_id}}, _) do
    case Diy.increase_project_comment_report_count(project_comment_id) do
      {1, nil} -> {:ok, %{reported: true}}
      _ -> {:ok, %{reported: false}}
    end
  end

  def project_comment_project(project_comment, _, _) do
    Helpers.batch_by_id(Diy.Project, project_comment.project_id)
  end

  def project_comment_parent(project_comment, _, _) do
    Helpers.batch_by_id(Diy.ProjectComment, project_comment.parent_id)
  end

  def project_comment_user(project_comment, _, _) do
    Helpers.batch_by_id(Accounts.User, project_comment.user_id)
  end

  def replies_for_project_comment(project_comment, pagination_args, _) do
    Ecto.assoc(project_comment, :replies)
    |> Diy.project_comments_query(pagination_args)
    |> Connection.from_query(&Repo.all/1, pagination_args)
  end
end
