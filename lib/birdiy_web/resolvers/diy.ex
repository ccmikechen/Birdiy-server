defmodule BirdiyWeb.Resolvers.Diy do
  alias Birdiy.{Repo, Diy, Accounts}
  alias BirdiyWeb.Schema.Helpers

  def projects(_, _, _) do
    {:ok, Diy.list_projects()}
  end

  def project_author(project, _, _) do
    Helpers.batch_by_id(Accounts.User, project.author_id)
  end

  def project_category(project, _, _) do
    Helpers.batch_by_id(Diy.ProjectCategory, project.category_id)
  end

  def projects_for_user(user, _, _) do
    query = Ecto.assoc(user, :projects)
    {:ok, Repo.all(query)}
  end
end
