defmodule Birdiy.Repo.Migrations.CreateProjectMethods do
  use Ecto.Migration

  def change do
    create table(:project_methods) do
      add :title, :string
      add :image, :string
      add :content, :string, null: false
      add :order, :decimal, null: false
      add :project_id, references(:projects, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:project_methods, [:project_id])
  end
end
