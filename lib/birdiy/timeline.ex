defmodule Birdiy.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false
  alias Birdiy.Repo

  alias Birdiy.Timeline.{Post, PostPhoto}

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  def list_post_photos do
    Repo.all(PostPhoto)
  end

  def get_post_photo!(id), do: Repo.get!(PostPhoto, id)

  def get_first_photo_of_post!(post) do
    from(p in PostPhoto, where: p.post_id == ^post.id)
    |> first()
    |> Repo.one()
  end

  def create_post_photo(attrs \\ %{}) do
    %PostPhoto{}
    |> PostPhoto.changeset(attrs)
    |> Repo.insert()
  end

  def update_post_photo(%PostPhoto{} = post_photo, attrs) do
    post_photo
    |> PostPhoto.changeset(attrs)
    |> Repo.update()
  end

  def delete_post_photo(%PostPhoto{} = post_photo) do
    Repo.delete(post_photo)
  end

  def change_post_photo(%PostPhoto{} = post_photo) do
    PostPhoto.changeset(post_photo, %{})
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
