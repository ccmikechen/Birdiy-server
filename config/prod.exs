use Mix.Config

config :birdiy, BirdiyWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  code_reloader: false

config :logger, level: :info
config :phoenix, :serve_endpoints, true

config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: "sgp1",
  s3: [
    scheme: "https://",
    host: "birdiy-dev-trail.sgp1.digitaloceanspaces.com",
    region: "sgp1"
  ]

# Configures Guardian
config :birdiy, Birdiy.Guardian,
  issuer: "birdiy",
  secret_key: "z46Dp+Dy5xTYrNqiNqIjwtNfPyqwKCWzfsn9Wt1wodvnlRsBzQmWdY/GUcucdJKn"

import_config "prod.secret.exs"
