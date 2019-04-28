defmodule BirdiyWeb.Resolvers.Timeline do
  import Ecto.Query
  import Absinthe.Resolution.Helpers

  alias Absinthe.Relay.Connection
  alias Birdiy.{Repo, Timeline, Diy, Accounts}
  alias BirdiyWeb.Schema.Helpers

  def posts(pagination_args, _) do
    from(Timeline.Post, order_by: [desc: :inserted_at])
    |> Connection.from_query(&Repo.all/1, pagination_args)
  end

  def post(_, %{id: id}, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Timeline, Timeline.Post, id)
    |> on_load(fn loader ->
      {:ok, Dataloader.get(loader, Timeline, Timeline.Post, id)}
    end)
  end

  def post_author(post, _, _) do
    Helpers.batch_by_id(Accounts.User, post.author_id)
  end

  def post_related_project(post, _, _) do
    Helpers.batch_by_id(Diy.Project, post.related_project_id)
  end

  def posts_for_user(pagination_args, %{source: user}) do
    Helpers.assoc_connection(user, :posts, pagination_args)
  end

  def photo_post(post_photo, _, _) do
    Helpers.batch_by_id(Timeline.Post, post_photo.post_id)
  end

  def photos_for_post(post, _, _) do
    {:ok, Timeline.get_post_photos!(post)}
  end

  def thumbnail_for_post(post, _, _) do
    {:ok, Timeline.get_post_thumbnail!(post)}
  end

  def create_post(_, %{input: params}, %{context: %{current_user: current_user}}) do
    case Timeline.create_post(current_user, params) do
      {:ok, post} -> {:ok, %{post: post}}
      _ -> {:error, nil}
    end
  end

  def edit_post(_, %{input: params}, %{context: %{current_user: current_user}}) do
    with post = Timeline.get_post!(params[:id]) do
      case Timeline.update_post(post, current_user, params) do
        {:ok, post} ->
          {:ok, %{post: post}}

        _ ->
          {:error, nil}
      end
    end
  end
end
