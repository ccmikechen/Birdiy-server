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
  alias Birdiy.Timeline.{Post, PostPhoto, Activity}
  alias Birdiy.Diy.Project

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

  def count_post_photos!(%Post{} = post) do
    Ecto.assoc(post, :photos)
    |> Repo.aggregate(:count, :id)
  end

  def create_post(%User{} = author, attrs \\ %{}) do
    result =
      Multi.new()
      |> create_post_query(author, attrs)
      |> create_post_activity_query()
      |> Repo.transaction()

    case result do
      {:ok, %{create_post: post}} ->
        {:ok, post}

      _ ->
        nil
    end
  end

  defp create_post_query(multi, author, attrs) do
    changeset = Post.changeset(%Post{author: author}, attrs)
    Multi.insert(multi, :create_post, changeset)
  end

  defp create_post_activity_query(multi) do
    Multi.run(
      multi,
      :create_post_activity,
      fn _, %{create_post: post} ->
        create_activity(%{post_id: post.id})
      end
    )
  end

  def update_post(%Post{} = post, %User{} = author, attrs) do
    post = Repo.preload(post, [:photos])

    result =
      Multi.new()
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
      attrs = Map.merge(attrs, %{author: author})
      changeset = Post.update_changeset(post, attrs)
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

  defp create_post_photo_query(attrs, _, %{create_post: post}) do
    attrs = Map.merge(attrs, %{post_id: post.id})
    changeset = PostPhoto.changeset(%PostPhoto{}, attrs)
    Repo.insert(changeset)
  end

  def create_post_photo(attrs) do
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

  def activities_query(args), do: activities_query(Activity, args)

  def activities_query(query, args) do
    q =
      Enum.reduce(args, query, fn
        {:order, :newest}, query ->
          query |> order_by(desc: :inserted_at)

        _, query ->
          query
      end)

    from(a in q,
      left_join: post in Post,
      on: a.post_id == post.id,
      left_join: project in Project,
      on: a.project_id == project.id,
      where:
        (not is_nil(post.id) and is_nil(post.deleted_at)) or
          (not is_nil(project.id) and is_nil(project.deleted_at) and
             not is_nil(project.published_at))
    )
  end

  def get_activity!(id), do: Repo.get!(Activity, id)

  def create_activity(attrs) do
    changeset = Activity.changeset(%Activity{}, attrs)
    Repo.insert(changeset)
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end

  def list_activities do
    Repo.all(Activity)
  end
end
