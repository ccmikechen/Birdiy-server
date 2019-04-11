defmodule BirdiyWeb.Resolvers.Diy do
  alias Birdiy.{Repo, Diy}

  def projects(_, _, _) do
    {:ok, Diy.list_projects() |> Repo.preload([:author, :category])}
  end
end
