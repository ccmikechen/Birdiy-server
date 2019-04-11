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
end
