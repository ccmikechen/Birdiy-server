defmodule BirdiyWeb.PageController do
  use BirdiyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
