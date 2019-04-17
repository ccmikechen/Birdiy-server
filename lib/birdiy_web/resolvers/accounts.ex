defmodule BirdiyWeb.Resolvers.Accounts do
  import Ecto.Query

  alias Absinthe.Relay.Connection
  alias Birdiy.{Repo, Accounts, Timeline}
  alias BirdiyWeb.Schema.Helpers

  def viewer(_, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def following_users(user, _, _) do
    Helpers.assoc(user, :following_users)
  end

  def following_user_posts(pagination_args, %{source: user}) do
    from(p in Timeline.Post,
      join: u in Accounts.UserFollowing,
      where: u.followed_id == p.author_id and u.following_id == ^user.id,
      order_by: [desc: :inserted_at]
    )
    |> Connection.from_query(&Repo.all/1, pagination_args)
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
