defmodule BirdiyWeb.SearchController do
  use BirdiyWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/download")
  end

  def show(conn, %{"text" => text}) do
    redirect(conn, to: Routes.download_path(conn, :index, search: text))
  end
end
