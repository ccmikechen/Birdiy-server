defmodule Birdiy.Repo.Migrations.AddGoogleIdToUsers do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :google_id, :string
    end

    create unique_index(:users, :google_id)
  end

  def down do
    alter table(:users) do
      remove :google_id
    end
  end
end
