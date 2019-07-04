defmodule Birdiy.Repo.Migrations.AddBannedAtToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :banned_at, :utc_datetime
    end
  end
end
