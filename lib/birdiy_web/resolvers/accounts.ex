defmodule BirdiyWeb.Resolvers.Accounts do
  import Ecto.Query

  alias Absinthe.Relay.Connection
  alias Birdiy.{Repo, Accounts, Timeline, Diy}
  alias BirdiyWeb.Schema.Helpers

  def viewer(_, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def user_followed(user, _, %{context: %{current_user: current_user}}) do
    case Accounts.get_user_following(current_user.id, user.id) do
      %Accounts.UserFollowing{} -> {:ok, true}
      _ -> {:ok, false}
    end
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

  def favorite_projects_for_user(pagination_args, %{source: user}) do
    Helpers.assoc_connection(user, :favorite_projects, pagination_args)
  end

  def liked_projects_for_user(pagination_args, %{source: user}) do
    Helpers.assoc_connection(user, :liked_projects, pagination_args)
  end

  def viewed_projects_for_user(pagination_args, %{source: user}) do
    Helpers.assoc_connection(user, :viewed_projects, pagination_args)
  end

  def following_count_for_user(user, _, _) do
    {:ok, Accounts.count_user_followings!(user)}
  end

  def follower_count_for_user(user, _, _) do
    {:ok, Accounts.count_user_followers!(user)}
  end

  def follow_user(_, %{input: %{id: user_id}}, %{context: %{current_user: current_user}}) do
    case Accounts.create_user_following(%{following_id: current_user.id, followed_id: user_id}) do
      {:ok, _} ->
        {:ok, %{following_user: current_user, followed_user: Accounts.get_user!(user_id)}}

      _ ->
        {:error, nil}
    end
  end

  def cancel_follow_user(_, %{input: %{id: user_id}}, %{
        context: %{current_user: current_user}
      }) do
    case Accounts.delete_user_following(current_user.id, user_id) do
      {:ok, _} ->
        {:ok, %{following_user: current_user, followed_user: Accounts.get_user!(user_id)}}

      _ ->
        {:error, nil}
    end
  end

  def project_count_for_user(user, _, _) do
    {:ok, Accounts.count_user_projects!(user, true)}
  end

  def project_count_for_viewer(viewer, _, _) do
    {:ok, Accounts.count_user_projects!(viewer)}
  end

  def projects_for_user(pagination_args, %{source: user}) do
    query =
      Ecto.assoc(user, :projects)
      |> Diy.projects_query(pagination_args)

    Connection.from_query(query, &Repo.all/1, pagination_args)
  end

  def projects_for_user(pagination_args, context, published) when is_boolean(published) do
    args = Map.put(pagination_args, :published, published)
    projects_for_user(args, context)
  end

  def favorite_project(_, %{input: %{id: project_id}}, %{context: %{current_user: current_user}}) do
    case Accounts.create_user_favorite_project(%{user_id: current_user.id, project_id: project_id}) do
      {:ok, _} -> {:ok, %{project: Diy.get_project!(project_id)}}
      _ -> {:error, nil}
    end
  end

  def cancel_favorite_project(_, %{input: %{id: project_id}}, %{
        context: %{current_user: current_user}
      }) do
    case Accounts.delete_user_favorite_project(current_user.id, project_id) do
      {:ok, _} -> {:ok, %{project: Diy.get_project!(project_id)}}
      _ -> {:error, nil}
    end
  end

  def like_project(_, %{input: %{id: project_id}}, %{context: %{current_user: current_user}}) do
    case Accounts.create_user_liked_project(%{user_id: current_user.id, project_id: project_id}) do
      {:ok, _} -> {:ok, %{project: Diy.get_project!(project_id)}}
      _ -> {:error, nil}
    end
  end

  def cancel_like_project(_, %{input: %{id: project_id}}, %{
        context: %{current_user: current_user}
      }) do
    case Accounts.delete_user_liked_project(current_user.id, project_id) do
      {:ok, _} -> {:ok, %{project: Diy.get_project!(project_id)}}
      _ -> {:error, nil}
    end
  end

  def view_project(_, %{input: %{id: project_id}}, %{context: %{current_user: current_user}}) do
    case Accounts.create_user_viewed_project(%{user_id: current_user.id, project_id: project_id}) do
      {:ok, _} -> {:ok, %{project: Diy.get_project!(project_id)}}
      _ -> {:error, nil}
    end
  end

  def posts_for_user(pagination_args, %{source: user}) do
    query =
      Ecto.assoc(user, :posts)
      |> Timeline.posts_query(pagination_args)

    Connection.from_query(query, &Repo.all/1, pagination_args)
  end
end
