defmodule BirdiyWeb.SitemapView do
  use BirdiyWeb, :view

  @host "birdiy.com"

  def loc(path) do
    %URI{scheme: "https", host: @host, path: path}
    |> URI.to_string()
  end

  def project_global_id(%Birdiy.Diy.Project{} = project) do
    Absinthe.Relay.Node.to_global_id("Project", project.id)
  end
end
