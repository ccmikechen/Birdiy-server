defmodule Birdiy.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :image, :string

      timestamps()
    end

  end
end
