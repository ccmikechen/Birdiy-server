defmodule BirdiyWeb.DownloadController do
  use BirdiyWeb, :controller

  def index(conn, %{"search" => search}) do
    render(conn, "index.html", search: search)
  end

  def index(conn, params) do
    render(conn, "index.html")
  end
end
