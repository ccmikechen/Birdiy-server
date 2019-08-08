use Mix.Config

config :birdiy, BirdiyWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  code_reloader: false,
  root: ".",
  version: Mix.Project.config()[:version]

config :logger, level: :info
config :phoenix, :serve_endpoints, true

config :birdiy, Birdiy.Repo,
  ssl: true,
  prepare: :unnamed

import_config "prod.secret.exs"
