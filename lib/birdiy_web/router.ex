defmodule BirdiyWeb.Router do
  use BirdiyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug BirdiyWeb.Context
  end

  scope "/", BirdiyWeb do
    pipe_through :browser

    get "/", HomeController, :index
  end

  scope "/api" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: BirdiyWeb.Schema
  end

  scope "/graphiql" do
    pipe_through :api

    forward "/", Absinthe.Plug.GraphiQL,
      schema: BirdiyWeb.Schema,
      socket: BirdiyWeb.UserSocket
  end
end
