defmodule BirdiyWeb.Resolvers.Timeline do
  alias Birdiy.{Repo, Timeline, Diy, Accounts}
  alias BirdiyWeb.Schema.Helpers

  def posts(_, _, _) do
    {:ok, Timeline.list_posts() |> Repo.preload([:author, :related_project])}
  end

  def post_author(post, _, _) do
    Helpers.batch_by_id(Accounts.User, post.author_id)
  end

  def post_related_project(post, _, _) do
    Helpers.batch_by_id(Diy.Project, post.related_project_id)
  end

  def posts_for_user(user, _, _) do
    query = Ecto.assoc(user, :posts)
    {:ok, Repo.all(query)}
  end
end
