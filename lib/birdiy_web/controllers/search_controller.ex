defmodule BirdiyWeb.SearchController do
  use BirdiyWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/download")
  end

  def show(conn, %{"text" => text}) do
    render(conn, "show.html", search_text: text)
  end
end
