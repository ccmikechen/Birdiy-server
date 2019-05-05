defmodule Birdiy.Repo.Migrations.AddRefreshKeyToUsers do
  use Ecto.Migration

  alias Birdiy.Helpers.Random

  def up do
    alter table(:users) do
      add :access_key, :string, size: 8, null: false, default: Random.refresh_key()
    end
  end

  def down do
    alter table(:users) do
      remove :access_key
    end
  end
end
