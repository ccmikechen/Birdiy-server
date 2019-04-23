defmodule Birdiy.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Birdiy.Repo

  alias Birdiy.Accounts.{
    User,
    UserFollowing,
    UserFavoriteProject,
    UserLikedProject,
    UserViewedProject
  }

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def count_user_projects!(%User{} = user) do
    Ecto.assoc(user, :projects)
    |> Repo.aggregate(:count, :id)
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

  def create_user_following(attrs \\ %{}) do
    %UserFollowing{}
    |> UserFollowing.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_following(%UserFollowing{} = user_following, attrs) do
    user_following
    |> UserFollowing.changeset(attrs)
    |> Repo.update()
  end

  def delete_user_following(%UserFollowing{} = user_following) do
    Repo.delete(user_following)
  end

  def get_user_favorite_project!(id), do: Repo.get!(UserFavoriteProject, id)

  def create_user_favorite_project(attrs \\ %{}) do
    %UserFavoriteProject{}
    |> UserFavoriteProject.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_favorite_project(%UserFavoriteProject{} = user_favorite_project, attrs) do
    user_favorite_project
    |> UserFavoriteProject.changeset(attrs)
    |> Repo.update()
  end

  def delete_user_favorite_project(%UserFavoriteProject{} = user_favorite_project) do
    Repo.delete(user_favorite_project)
  end

  def get_user_liked_project!(id), do: Repo.get!(UserLikedProject, id)

  def create_user_liked_project(attrs \\ %{}) do
    %UserLikedProject{}
    |> UserLikedProject.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_liked_project(%UserLikedProject{} = user_liked_project, attrs) do
    user_liked_project
    |> UserLikedProject.changeset(attrs)
    |> Repo.update()
  end

  def delete_user_liked_project(%UserLikedProject{} = user_liked_project) do
    Repo.delete(user_liked_project)
  end

  def get_user_viewed_project!(id), do: Repo.get!(UserViewedProject, id)

  def create_user_viewed_project(attrs \\ %{}) do
    %UserViewedProject{}
    |> UserViewedProject.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_viewed_project(%UserViewedProject{} = user_viewed_project, attrs) do
    user_viewed_project
    |> UserViewedProject.changeset(attrs)
    |> Repo.update()
  end

  def delete_user_viewed_project(%UserViewedProject{} = user_viewed_project) do
    Repo.delete(user_viewed_project)
  end
end
