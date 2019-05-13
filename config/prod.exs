use Mix.Config

config :birdiy, BirdiyWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  code_reloader: false

config :logger, level: :info
config :phoenix, :serve_endpoints, true

config :birdiy, Birdiy.Repo, ssl: true

import_config "prod.secret.exs"
