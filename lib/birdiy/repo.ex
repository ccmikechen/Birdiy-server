defmodule Birdiy.Repo do
  use Ecto.Repo,
    otp_app: :birdiy,
    adapter: Ecto.Adapters.Postgres

  use Ecto.SoftDelete.Repo
end
