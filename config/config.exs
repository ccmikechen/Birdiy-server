# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :birdiy,
  ecto_repos: [Birdiy.Repo]

# Configures the endpoint
config :birdiy, BirdiyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ubJ3TJOu1MsGHUxof0x80FJes2JxXsYnKrtNK52LcYvJrjm7eTy0YZfnGywz+nwm",
  render_errors: [view: BirdiyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Birdiy.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Admin

config :ex_admin,
  repo: Birdiy.Repo,
  module: BirdiyWeb,
  modules: [
    BirdiyWeb.ExAdmin.Dashboard,
  ],
  skin_color: :black

config :gettext, default_locale: "en/us"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :xain, :after_callback, {Phoenix.HTML, :raw}

