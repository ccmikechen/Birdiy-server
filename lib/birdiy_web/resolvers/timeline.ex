defmodule BirdiyWeb.Resolvers.Timeline do
  alias Birdiy.{Repo, Timeline}

  def posts(_, _, _) do
    {:ok, Timeline.list_posts() |> Repo.preload([:author, :related_project])}
  end
end
