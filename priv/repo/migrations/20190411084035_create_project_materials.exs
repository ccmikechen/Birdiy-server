defmodule Birdiy.Repo.Migrations.CreateProjectMaterials do
  use Ecto.Migration

  def change do
    create table(:project_materials) do
      add :name, :string, null: false
      add :amountUnit, :string, null: false
      add :url, :string
      add :project_id, references(:projects, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:project_materials, [:project_id])
  end
end
