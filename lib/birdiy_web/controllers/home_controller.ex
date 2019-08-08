defmodule BirdiyWeb.HomeController do
  use BirdiyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", %{hide_logo: true})
  end
end
