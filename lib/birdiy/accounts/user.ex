defmodule Birdiy.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :image, :string
    field :name, :string, size: 20

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :image])
    |> validate_required([:name])
  end
end
