defmodule BirdiyWeb.Resolvers.Diy do
  import Ecto.Query

  alias Absinthe.Relay.Connection
  alias Birdiy.{Repo, Diy, Accounts}
  alias BirdiyWeb.Schema.Helpers

  def projects(pagination_args, _) do
    from(Diy.Project, order_by: [desc: :inserted_at])
    |> Connection.from_query(&Repo.all/1, pagination_args)
  end

  def project_author(project, _, _) do
    Helpers.batch_by_id(Accounts.User, project.author_id)
  end

  def project_category(project, _, _) do
    Helpers.batch_by_id(Diy.ProjectCategory, project.category_id)
  end

  def projects_for_user(user, _, _) do
    Helpers.assoc(user, :projects)
  end

  def projects_for_category(category, _, _) do
    Helpers.assoc(category, :projects)
  end

  def material_project(material, _, _) do
    Helpers.batch_by_id(Diy.Project, material.project_id)
  end

  def materials_for_project(project, _, _) do
    Helpers.assoc(project, :materials)
  end

  def file_resource_project(file_resource, _, _) do
    Helpers.batch_by_id(Diy.Project, file_resource.project_id)
  end

  def file_resources_for_project(project, _, _) do
    Helpers.assoc(project, :file_resources)
  end

  def method_project(method, _, _) do
    Helpers.batch_by_id(Diy.Project, method.project_id)
  end

  def methods_for_project(project, _, _) do
    Helpers.assoc(project, :methods)
  end

  def related_posts_for_project(project, _, _) do
    Helpers.assoc(project, :related_posts)
  end
end
