defmodule Birdiy.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :email, :string, null: false
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:admins, [:email])
  end
end
