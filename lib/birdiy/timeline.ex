defmodule Birdiy.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false
  import Ecto.SoftDelete.Query

  alias Ecto.Multi
  alias Birdiy.Repo
  alias Birdiy.Helpers

  alias Birdiy.Accounts.User
  alias Birdiy.Timeline.{Post, PostPhoto}

  def list_posts do
    Repo.all(Post) |> with_undeleted()
  end

  def posts_query(args), do: posts_query(Post, args)

  def posts_query(query, args) do
    Enum.reduce(args, query, fn
      {:order, :newest}, query ->
        query |> order_by(desc: :inserted_at)

      {:before_post, %Post{} = post}, query ->
        query |> where([p], p.id <= ^post.id)

      _, query ->
        query
    end)
    |> with_undeleted()
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(%User{} = author, attrs \\ %{}) do
    result =
      Multi.new()
      |> create_post_query(author, attrs)
      |> create_post_photos_query(attrs[:photos])
      |> Repo.transaction()

    case result do
      {:ok, %{create_post: post}} ->
        {:ok, post}

      _ ->
        nil
    end
  end

  defp create_post_query(multi, author, attrs) do
    changeset = Post.changeset(%Post{}, author, attrs)
    Multi.insert(multi, :create_post, changeset)
  end

  def update_post(%Post{} = post, %User{} = author, attrs) do
    result =
      Multi.new()
      |> upsert_post_photos_query(post, attrs[:photos])
      |> update_post_query(post, author, attrs)
      |> Repo.transaction()

    case result do
      {:ok, %{update_post: post}} ->
        {:ok, post}

      _ ->
        nil
    end
  end

  defp update_post_query(multi, %Post{} = post, %User{} = author, attrs) do
    Multi.run(multi, :update_post, fn _, _ ->
      changeset = Post.update_changeset(post, author, attrs)
      Repo.update(changeset)
    end)
  end

  def delete_post(%Post{} = post) do
    Repo.soft_delete(post)
  end

  def get_post_photo!(id), do: Repo.get!(PostPhoto, id)

  def get_post_photos!(%Post{} = post) do
    Ecto.assoc(post, :photos)
    |> order_by(:order)
    |> Repo.all()
  end

  def get_post_thumbnail!(%Post{} = post) do
    from(p in PostPhoto, where: p.post_id == ^post.id and is_nil(p.deleted_at))
    |> first()
    |> Repo.one()
  end

  defp create_post_photos_query(multi, params) do
    params
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {attrs, index}, multi ->
      Multi.run(
        multi,
        "create_post_photo_#{index}",
        &create_post_photo_query(attrs, &1, &2)
      )
    end)
  end

  defp create_post_photo_query(attrs, _, %{create_post: post}) do
    attrs = Map.merge(attrs, %{post_id: post.id})
    changeset = PostPhoto.changeset(%PostPhoto{}, attrs)
    Repo.insert(changeset)
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
