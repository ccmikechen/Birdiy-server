defmodule Birdiy.Repo do
  use Ecto.Repo,
    otp_app: :birdiy,
    adapter: Ecto.Adapters.Postgres

  use Ecto.SoftDelete.Repo
  use Scrivener, page_size: 10
end
