defmodule Birdiy.Repo.Migrations.CreateProjectFileResources do
  use Ecto.Migration

  def change do
    create table(:project_file_resources) do
      add :name, :string, null: false
      add :url, :string, null: false
      add :project_id, references(:projects, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:project_file_resources, [:project_id])
  end
end
