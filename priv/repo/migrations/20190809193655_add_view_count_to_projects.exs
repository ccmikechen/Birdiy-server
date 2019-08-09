defmodule Birdiy.Repo.Migrations.AddViewCountToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :view_count, :integer, null: false, default: 0
    end
  end
end
