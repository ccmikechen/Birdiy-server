defmodule BirdiyWeb.SitemapController do
  use BirdiyWeb, :controller

  alias Birdiy.Diy

  def index(conn, _params) do
    render(conn, "index.xml", %{
      lastmod: DateTime.utc_now() |> DateTime.to_iso8601(),
      categories: Diy.list_project_categories(),
      topics: Diy.list_project_topics(),
      projects: Diy.list_projects()
    })
  end
end
