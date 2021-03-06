defmodule BirdiyWeb.Router do
  use BirdiyWeb, :router
  use ExAdmin.Router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :xml do
    plug :accepts, ["xml"]
    plug :put_resp_content_type, "application/xml"
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug BirdiyWeb.Context
  end

  pipeline :protected_admin do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/", BirdiyWeb do
    pipe_through :browser

    get "/", HomeController, :index
    get "/download/", DownloadController, :index
    resources "/search", SearchController, only: [:index, :show], param: "text"
    resources "/categories", CategoryController, only: [:index, :show], param: "name"
    resources "/topics", TopicController, only: [:index, :show], param: "name"
    get "/project/:id", ProjectController, :show

    get "/privacy", PrivacyController, :index
    get "/terms", TermsController, :index
  end

  scope "/", BirdiyWeb do
    pipe_through :xml
    get "/sitemap.xml", SitemapController, :index
  end

  scope "/admin" do
    pipe_through :browser
    pow_session_routes()
  end

  scope "/admin", ExAdmin do
    pipe_through [:browser, :protected_admin]
    admin_routes()
  end

  scope "/api" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: BirdiyWeb.Schema
  end

  if Mix.env() == :dev do
    scope "/graphiql" do
      pipe_through :api

      forward "/", Absinthe.Plug.GraphiQL,
        schema: BirdiyWeb.Schema,
        socket: BirdiyWeb.UserSocket
    end
  end
end
