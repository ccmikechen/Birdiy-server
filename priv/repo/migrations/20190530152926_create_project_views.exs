defmodule Birdiy.Repo.Migrations.CreateProjectViews do
  use Ecto.Migration

  def change do
    create table(:project_views) do
      add :ip, :string, null: false
      add :project_id, references(:projects, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:project_views, [:ip, :project_id])
  end
end
