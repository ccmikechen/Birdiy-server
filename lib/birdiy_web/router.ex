defmodule BirdiyWeb.Router do
  use BirdiyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BirdiyWeb do
    pipe_through :api
  end
end
