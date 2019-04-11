defmodule Birdiy.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false
  alias Birdiy.Repo

  alias Birdiy.Timeline.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  alias Birdiy.Timeline.PostPhoto

  @doc """
  Returns the list of post_photos.

  ## Examples

      iex> list_post_photos()
      [%PostPhoto{}, ...]

  """
  def list_post_photos do
    Repo.all(PostPhoto)
  end

  @doc """
  Gets a single post_photo.

  Raises `Ecto.NoResultsError` if the Post photo does not exist.

  ## Examples

      iex> get_post_photo!(123)
      %PostPhoto{}

      iex> get_post_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post_photo!(id), do: Repo.get!(PostPhoto, id)

  @doc """
  Creates a post_photo.

  ## Examples

      iex> create_post_photo(%{field: value})
      {:ok, %PostPhoto{}}

      iex> create_post_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post_photo(attrs \\ %{}) do
    %PostPhoto{}
    |> PostPhoto.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post_photo.

  ## Examples

      iex> update_post_photo(post_photo, %{field: new_value})
      {:ok, %PostPhoto{}}

      iex> update_post_photo(post_photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post_photo(%PostPhoto{} = post_photo, attrs) do
    post_photo
    |> PostPhoto.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PostPhoto.

  ## Examples

      iex> delete_post_photo(post_photo)
      {:ok, %PostPhoto{}}

      iex> delete_post_photo(post_photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post_photo(%PostPhoto{} = post_photo) do
    Repo.delete(post_photo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post_photo changes.

  ## Examples

      iex> change_post_photo(post_photo)
      %Ecto.Changeset{source: %PostPhoto{}}

  """
  def change_post_photo(%PostPhoto{} = post_photo) do
    PostPhoto.changeset(post_photo, %{})
  end
end
