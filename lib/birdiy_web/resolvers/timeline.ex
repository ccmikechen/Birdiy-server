defmodule BirdiyWeb.Resolvers.Timeline do
  import Absinthe.Resolution.Helpers

  alias Absinthe.Relay.Connection
  alias Birdiy.{Repo, Timeline, Diy, Accounts}
  alias BirdiyWeb.Schema.Helpers
  alias BirdiyWeb.Errors

  def posts(pagination_args, _) do
    Connection.from_query(
      Timeline.posts_query(pagination_args),
      &Repo.all/1,
      pagination_args
    )
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

  def photo_post(post_photo, _, _) do
    Helpers.batch_by_id(Timeline.Post, post_photo.post_id)
  end

  def photos_for_post(post, _, _) do
    {:ok, Timeline.get_post_photos!(post)}
  end

  def photos_count_for_post(post, _, _) do
    {:ok, Timeline.count_post_photos!(post)}
  end

  def thumbnail_for_post(post, _, _) do
    {:ok, Timeline.get_post_thumbnail!(post)}
  end

  def create_post(_, %{input: params}, %{context: %{current_user: current_user}}) do
    case Timeline.create_post(current_user, params) do
      {:ok, post} -> {:ok, %{post: post}}
      _ -> Errors.create_post()
    end
  end

  def edit_post(_, %{input: params}, %{context: %{current_user: current_user}}) do
    with post = Timeline.get_post!(params[:id]) do
      case Timeline.update_post(post, current_user, params) do
        {:ok, post} ->
          {:ok, %{post: post}}

        _ ->
          Errors.update_post()
      end
    end
  end

  def delete_post(_, %{input: %{post: post}}, _) do
    case Timeline.delete_post(post) do
      {:ok, post} ->
        {:ok, %{post: post}}

      _ ->
        Errors.delete_post()
    end
  end

  def report_post(_, %{input: %{id: post_id}}, _) do
    case Timeline.increase_post_report_count(post_id) do
      {1, nil} -> {:ok, %{reported: true}}
      _ -> {:ok, %{reported: false}}
    end
  end

  def activities(pagination_args, _) do
    Connection.from_query(
      Timeline.activities_query(pagination_args),
      &Repo.all/1,
      pagination_args
    )
  end

  def activity_project(activity, _, _) do
    Helpers.batch_by_id(Diy.Project, activity.project_id)
  end

  def activity_post(activity, _, _) do
    Helpers.batch_by_id(Timeline.Post, activity.post_id)
  end
end
