defmodule Birdiy.Accounts.Admin do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "admins" do
    pow_user_fields()

    timestamps()
  end
end
