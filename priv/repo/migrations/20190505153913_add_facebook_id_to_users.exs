defmodule Birdiy.Repo.Migrations.AddFacebookIdToUsers do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :facebook_id, :string
    end

    create unique_index(:users, :facebook_id)
  end

  def down do
    alter table(:users) do
      remove :facebook_id
    end
  end
end
