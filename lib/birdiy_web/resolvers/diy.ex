defmodule BirdiyWeb.Resolvers.Diy do
  import Ecto.Query
  import Absinthe.Resolution.Helpers

  alias Absinthe.Relay.Connection
  alias Birdiy.{Repo, Diy, Accounts}
  alias BirdiyWeb.Schema.Helpers

  def project_categories(pagination_args, _) do
    Connection.from_query(
      Diy.project_categories_query(pagination_args),
      &Repo.all/1,
      pagination_args
    )
  end

  def projects(pagination_args, _) do
    Connection.from_query(
      Diy.projects_query(pagination_args),
      &Repo.all/1,
      pagination_args
    )
  end

  def project(_, %{id: id}, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Diy, Diy.Project, id)
    |> on_load(fn loader ->
      {:ok, Dataloader.get(loader, Diy, Diy.Project, id)}
    end)
  end

  def project_author(project, _, _) do
    Helpers.batch_by_id(Accounts.User, project.author_id)
  end

  def project_category(project, _, _) do
    Helpers.batch_by_id(Diy.ProjectCategory, project.category_id)
  end

  def projects_for_category(category, _, _) do
    Helpers.assoc(category, :projects)
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

  def project_related_post_count(project, _, _) do
    {:ok, Diy.count_project_related_posts!(project)}
  end

  def project_view_count(project, _, _) do
    {:ok, Diy.count_project_views!(project)}
  end

  def project_favorite_count(project, _, _) do
    {:ok, Diy.count_project_favorites!(project)}
  end

  def project_like_count(project, _, _) do
    {:ok, Diy.count_project_likes!(project)}
  end
end
