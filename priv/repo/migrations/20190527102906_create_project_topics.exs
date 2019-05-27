defmodule Birdiy.Repo.Migrations.CreateProjectTopics do
  use Ecto.Migration

  def change do
    create table(:project_topics) do
      add :name, :string
      add :category_id, references(:project_categories, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:project_topics, [:name, :category_id])
  end
end
