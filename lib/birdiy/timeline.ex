defmodule Birdiy.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false
  alias Birdiy.Repo
  alias Ecto.Multi
  alias Birdiy.Helpers

  alias Birdiy.Accounts.User
  alias Birdiy.Timeline.{Post, PostPhoto}

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(%User{} = author, attrs \\ %{}) do
    {:ok, post} =
      %Post{}
      |> Post.changeset(author, attrs)
      |> Repo.insert()

    result =
      Multi.new()
      |> upsert_post_photos_query(post, attrs[:photos])
      |> Repo.transaction()

    case result do
      {:ok, _} ->
        {:ok, post}

      _ ->
        delete_post(post)
        nil
    end
  end

  def delete_post(%Post{} = post) do
    Repo.soft_delete(post)
  end

  def get_post_photo!(id), do: Repo.get!(PostPhoto, id)

  def get_post_thumbnail!(post) do
    from(p in PostPhoto, where: p.post_id == ^post.id)
    |> first()
    |> Repo.one()
  end

  defp upsert_post_photos_query(multi, %Post{} = post, params) do
    ids = params |> Enum.map(& &1[:id]) |> Enum.reject(&is_nil/1)
    multi = delete_post_items_not_in_list_query(multi, post, :photos, ids)

    params
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {attrs, index}, multi ->
      attrs = Map.merge(attrs, %{post_id: post.id})

      changeset =
        case attrs[:id] && get_post_photo!(attrs[:id]) do
          nil -> %PostPhoto{}
          photo -> photo
        end
        |> PostPhoto.changeset(attrs)

      Multi.insert_or_update(
        multi,
        "upsert_post_photo_#{index}",
        changeset
      )
    end)
  end

  defp delete_post_items_not_in_list_query(multi, %Post{} = post, item, ids) do
    delete_query =
      Ecto.assoc(post, item)
      |> where([m], m.id not in ^ids)

    Helpers.Multi.soft_delete_all(
      multi,
      "delete_" <> Atom.to_string(item),
      delete_query
    )
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
    Repo.soft_delete(post_photo)
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
