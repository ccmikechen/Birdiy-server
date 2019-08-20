defmodule Birdiy.Accounts do
  import Ecto.Query, warn: false

  alias Birdiy.{Repo, Auth}

  alias Birdiy.Avatar

  alias Birdiy.Accounts.{
    User,
    UserFollowing,
    UserFavoriteProject,
    UserLikedProject,
    UserViewedProject
  }

  alias Birdiy.Diy.Project
  alias Birdiy.Timeline.{Post, Activity}

  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id), do: Repo.get(User, id)

  def get_or_create_user_by(%{} = attrs) do
    case Repo.get_by(User, attrs) do
      nil -> %User{}
      user -> user
    end
    |> User.changeset(attrs)
    |> Repo.insert_or_update()
  end

  def get_or_create_user_by(:facebook, token) do
    case Auth.Facebook.auth(token) do
      {:ok, facebook_id} ->
        get_or_create_user_by(%{facebook_id: facebook_id})

      _ ->
        nil
    end
  end

  def get_or_create_user_by(:google, token) do
    case Auth.Google.auth(token) do
      {:ok, google_id} ->
        get_or_create_user_by(%{google_id: google_id})

      _ ->
        nil
    end
  end

  def get_or_create_user_by(method, _) do
    {:error, "Unknown method: #{method}"}
  end

  def count_user_projects!(%User{} = user) do
    count_user_projects!(user, nil)
  end

  def count_user_projects!(%User{} = user, published) do
    Ecto.assoc(user, :projects)
    |> user_projects_filter(published)
    |> Repo.aggregate(:count, :id)
  end

  defp user_projects_filter(query, published) do
    case published do
      true ->
        from(q in query, where: not is_nil(q.published_at))

      false ->
        from(q in query, where: is_nil(q.published_at))

      _ ->
        query
    end
  end

  def count_user_followings!(%User{} = user) do
    Ecto.assoc(user, :following_users)
    |> Repo.aggregate(:count, :id)
  end

  def count_user_followers!(%User{} = user) do
    Ecto.assoc(user, :followed_users)
    |> Repo.aggregate(:count, :id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def get_user_following!(id), do: Repo.get!(UserFollowing, id)

  def get_user_following(following_id, followed_id) do
    Repo.get_by(UserFollowing, following_id: following_id, followed_id: followed_id)
  end

  def get_user_following_users_query(%User{} = user) do
    user
    |> Ecto.assoc(:following_users)
    |> order_by(desc: :inserted_at)
  end

  def get_user_followed_users_query(%User{} = user) do
    user
    |> Ecto.assoc(:followed_users)
    |> order_by(desc: :inserted_at)
  end

  def create_user_following(attrs \\ %{}) do
    %UserFollowing{}
    |> UserFollowing.changeset(attrs)
    |> Repo.insert(
      on_conflict: :replace_all_except_primary_key,
      conflict_target: [:following_id, :followed_id]
    )
  end

  def update_user_following(%UserFollowing{} = user_following, attrs) do
    user_following
    |> UserFollowing.changeset(attrs)
    |> Repo.update()
  end

  def delete_user_following(following_id, followed_id) do
    case get_user_following(following_id, followed_id) do
      %UserFollowing{} = u ->
        delete_user_following(u)

      _ ->
        nil
    end
  end

  def delete_user_following(%UserFollowing{} = user_following) do
    Repo.delete(user_following)
  end

  def get_user_following_posts_query(%User{} = user) do
    from(p in Post,
      join: u in UserFollowing,
      where: u.followed_id == p.author_id and u.following_id == ^user.id,
      order_by: [desc: :inserted_at]
    )
  end

  def get_user_following_activities_query(%User{} = user) do
    from(a in Activity,
      left_join: post in Post,
      on: a.post_id == post.id,
      left_join: project in Project,
      on: a.project_id == project.id,
      join: u in UserFollowing,
      where:
        (not is_nil(post.id) and is_nil(post.deleted_at)) or
          (not is_nil(project.id) and is_nil(project.deleted_at) and
             not is_nil(project.published_at)),
      where: u.followed_id == post.author_id or u.followed_id == project.author_id,
      where: u.following_id == ^user.id
    )
  end

  def get_user_favorite_project!(id), do: Repo.get!(UserFavoriteProject, id)

  def get_user_favorite_project(user_id, project_id) do
    Repo.get_by(UserFavoriteProject, user_id: user_id, project_id: project_id)
  end

  def get_user_favorite_projects_query(%User{} = user) do
    user
    |> Ecto.assoc(:favorite_projects)
    |> order_by(desc: :inserted_at)
  end

  def create_user_favorite_project(attrs \\ %{}) do
    %UserFavoriteProject{}
    |> UserFavoriteProject.changeset(attrs)
    |> Repo.insert(
      on_conflict: :replace_all_except_primary_key,
      conflict_target: [:user_id, :project_id]
    )
  end

  def delete_user_favorite_project(%UserFavoriteProject{} = user_favorite_project) do
    Repo.delete(user_favorite_project)
  end

  def delete_user_favorite_project(user_id, project_id) do
    case get_user_favorite_project(user_id, project_id) do
      %UserFavoriteProject{} = u ->
        delete_user_favorite_project(u)

      _ ->
        nil
    end
  end

  def get_user_liked_project!(id), do: Repo.get!(UserLikedProject, id)

  def get_user_liked_project(user_id, project_id) do
    Repo.get_by(UserLikedProject, user_id: user_id, project_id: project_id)
  end

  def get_user_liked_projects_query(%User{} = user) do
    user
    |> Ecto.assoc(:liked_projects)
    |> order_by(desc: :inserted_at)
  end

  def create_user_liked_project(attrs \\ %{}) do
    %UserLikedProject{}
    |> UserLikedProject.changeset(attrs)
    |> Repo.insert(
      on_conflict: :replace_all_except_primary_key,
      conflict_target: [:user_id, :project_id]
    )
  end

  def delete_user_liked_project(%UserLikedProject{} = user_liked_project) do
    Repo.delete(user_liked_project)
  end

  def delete_user_liked_project(user_id, project_id) do
    case get_user_liked_project(user_id, project_id) do
      %UserLikedProject{} = u ->
        delete_user_liked_project(u)

      _ ->
        nil
    end
  end

  def get_user_viewed_project!(id), do: Repo.get!(UserViewedProject, id)

  def get_user_viewed_project(user_id, project_id) do
    Repo.get_by(UserViewedProject, user_id: user_id, project_id: project_id)
  end

  def get_user_viewed_projects_query(%User{} = user) do
    user
    |> Ecto.assoc(:viewed_projects)
    |> order_by(desc: :inserted_at)
  end

  def create_user_viewed_project(attrs \\ %{}) do
    %UserViewedProject{}
    |> UserViewedProject.changeset(attrs)
    |> Repo.insert(
      on_conflict: :replace_all_except_primary_key,
      conflict_target: [:user_id, :project_id]
    )
  end

  def avatar_url(%User{} = user) do
    Avatar.url_from(user)
  end
end
