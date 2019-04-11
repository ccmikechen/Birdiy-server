defmodule BirdiyWeb.Resolvers.Accounts do
  alias Birdiy.{Repo, Accounts}
  alias BirdiyWeb.Schema.Helpers

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def following_users(user, _, _) do
    Helpers.assoc(user, :following_users)
  end

  def followed_users(user, _, _) do
    Helpers.assoc(user, :followed_users)
  end

  def favorite_projects(user, _, _) do
    Helpers.assoc(user, :favorite_projects)
  end

  def liked_projects(user, _, _) do
    Helpers.assoc(user, :liked_projects)
  end

  def viewed_projects(user, _, _) do
    Helpers.assoc(user, :viewed_projects)
  end
end
