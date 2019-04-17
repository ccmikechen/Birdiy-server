defmodule BirdiyWeb.Router do
  use BirdiyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug BirdiyWeb.Context
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: BirdiyWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: BirdiyWeb.Schema,
      socket: BirdiyWeb.UserSocket
  end
end
