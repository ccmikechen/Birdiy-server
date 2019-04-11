defmodule Birdiy.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Birdiy.Repo

  alias Birdiy.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Birdiy.Accounts.UserFollowing

  @doc """
  Returns the list of user_followings.

  ## Examples

      iex> list_user_followings()
      [%UserFollowing{}, ...]

  """
  def list_user_followings do
    Repo.all(UserFollowing)
  end

  @doc """
  Gets a single user_following.

  Raises `Ecto.NoResultsError` if the User following does not exist.

  ## Examples

      iex> get_user_following!(123)
      %UserFollowing{}

      iex> get_user_following!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_following!(id), do: Repo.get!(UserFollowing, id)

  @doc """
  Creates a user_following.

  ## Examples

      iex> create_user_following(%{field: value})
      {:ok, %UserFollowing{}}

      iex> create_user_following(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_following(attrs \\ %{}) do
    %UserFollowing{}
    |> UserFollowing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_following.

  ## Examples

      iex> update_user_following(user_following, %{field: new_value})
      {:ok, %UserFollowing{}}

      iex> update_user_following(user_following, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_following(%UserFollowing{} = user_following, attrs) do
    user_following
    |> UserFollowing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserFollowing.

  ## Examples

      iex> delete_user_following(user_following)
      {:ok, %UserFollowing{}}

      iex> delete_user_following(user_following)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_following(%UserFollowing{} = user_following) do
    Repo.delete(user_following)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_following changes.

  ## Examples

      iex> change_user_following(user_following)
      %Ecto.Changeset{source: %UserFollowing{}}

  """
  def change_user_following(%UserFollowing{} = user_following) do
    UserFollowing.changeset(user_following, %{})
  end

  alias Birdiy.Accounts.UserFavoriteProject

  @doc """
  Returns the list of user_favorite_projects.

  ## Examples

      iex> list_user_favorite_projects()
      [%UserFavoriteProject{}, ...]

  """
  def list_user_favorite_projects do
    Repo.all(UserFavoriteProject)
  end

  @doc """
  Gets a single user_favorite_project.

  Raises `Ecto.NoResultsError` if the User favorite project does not exist.

  ## Examples

      iex> get_user_favorite_project!(123)
      %UserFavoriteProject{}

      iex> get_user_favorite_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_favorite_project!(id), do: Repo.get!(UserFavoriteProject, id)

  @doc """
  Creates a user_favorite_project.

  ## Examples

      iex> create_user_favorite_project(%{field: value})
      {:ok, %UserFavoriteProject{}}

      iex> create_user_favorite_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_favorite_project(attrs \\ %{}) do
    %UserFavoriteProject{}
    |> UserFavoriteProject.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_favorite_project.

  ## Examples

      iex> update_user_favorite_project(user_favorite_project, %{field: new_value})
      {:ok, %UserFavoriteProject{}}

      iex> update_user_favorite_project(user_favorite_project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_favorite_project(%UserFavoriteProject{} = user_favorite_project, attrs) do
    user_favorite_project
    |> UserFavoriteProject.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserFavoriteProject.

  ## Examples

      iex> delete_user_favorite_project(user_favorite_project)
      {:ok, %UserFavoriteProject{}}

      iex> delete_user_favorite_project(user_favorite_project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_favorite_project(%UserFavoriteProject{} = user_favorite_project) do
    Repo.delete(user_favorite_project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_favorite_project changes.

  ## Examples

      iex> change_user_favorite_project(user_favorite_project)
      %Ecto.Changeset{source: %UserFavoriteProject{}}

  """
  def change_user_favorite_project(%UserFavoriteProject{} = user_favorite_project) do
    UserFavoriteProject.changeset(user_favorite_project, %{})
  end

  alias Birdiy.Accounts.UserLikedProject

  @doc """
  Returns the list of user_liked_projects.

  ## Examples

      iex> list_user_liked_projects()
      [%UserLikedProject{}, ...]

  """
  def list_user_liked_projects do
    Repo.all(UserLikedProject)
  end

  @doc """
  Gets a single user_liked_project.

  Raises `Ecto.NoResultsError` if the User liked project does not exist.

  ## Examples

      iex> get_user_liked_project!(123)
      %UserLikedProject{}

      iex> get_user_liked_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_liked_project!(id), do: Repo.get!(UserLikedProject, id)

  @doc """
  Creates a user_liked_project.

  ## Examples

      iex> create_user_liked_project(%{field: value})
      {:ok, %UserLikedProject{}}

      iex> create_user_liked_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_liked_project(attrs \\ %{}) do
    %UserLikedProject{}
    |> UserLikedProject.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_liked_project.

  ## Examples

      iex> update_user_liked_project(user_liked_project, %{field: new_value})
      {:ok, %UserLikedProject{}}

      iex> update_user_liked_project(user_liked_project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_liked_project(%UserLikedProject{} = user_liked_project, attrs) do
    user_liked_project
    |> UserLikedProject.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserLikedProject.

  ## Examples

      iex> delete_user_liked_project(user_liked_project)
      {:ok, %UserLikedProject{}}

      iex> delete_user_liked_project(user_liked_project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_liked_project(%UserLikedProject{} = user_liked_project) do
    Repo.delete(user_liked_project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_liked_project changes.

  ## Examples

      iex> change_user_liked_project(user_liked_project)
      %Ecto.Changeset{source: %UserLikedProject{}}

  """
  def change_user_liked_project(%UserLikedProject{} = user_liked_project) do
    UserLikedProject.changeset(user_liked_project, %{})
  end

  alias Birdiy.Accounts.UserViewedProject

  @doc """
  Returns the list of user_viewed_projects.

  ## Examples

      iex> list_user_viewed_projects()
      [%UserViewedProject{}, ...]

  """
  def list_user_viewed_projects do
    Repo.all(UserViewedProject)
  end

  @doc """
  Gets a single user_viewed_project.

  Raises `Ecto.NoResultsError` if the User viewed project does not exist.

  ## Examples

      iex> get_user_viewed_project!(123)
      %UserViewedProject{}

      iex> get_user_viewed_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_viewed_project!(id), do: Repo.get!(UserViewedProject, id)

  @doc """
  Creates a user_viewed_project.

  ## Examples

      iex> create_user_viewed_project(%{field: value})
      {:ok, %UserViewedProject{}}

      iex> create_user_viewed_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_viewed_project(attrs \\ %{}) do
    %UserViewedProject{}
    |> UserViewedProject.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_viewed_project.

  ## Examples

      iex> update_user_viewed_project(user_viewed_project, %{field: new_value})
      {:ok, %UserViewedProject{}}

      iex> update_user_viewed_project(user_viewed_project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_viewed_project(%UserViewedProject{} = user_viewed_project, attrs) do
    user_viewed_project
    |> UserViewedProject.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserViewedProject.

  ## Examples

      iex> delete_user_viewed_project(user_viewed_project)
      {:ok, %UserViewedProject{}}

      iex> delete_user_viewed_project(user_viewed_project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_viewed_project(%UserViewedProject{} = user_viewed_project) do
    Repo.delete(user_viewed_project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_viewed_project changes.

  ## Examples

      iex> change_user_viewed_project(user_viewed_project)
      %Ecto.Changeset{source: %UserViewedProject{}}

  """
  def change_user_viewed_project(%UserViewedProject{} = user_viewed_project) do
    UserViewedProject.changeset(user_viewed_project, %{})
  end
end
