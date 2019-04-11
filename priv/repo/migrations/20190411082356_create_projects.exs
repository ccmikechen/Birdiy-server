defmodule Birdiy.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string, null: false
      add :introduction, :string
      add :tip, :string
      add :author_id, references(:users, on_delete: :nothing), null: false
      add :category_id, references(:project_categories, on_delete: :nothing), null: false
      add :published_at, :date

      timestamps()
    end

    create index(:projects, [:author_id])
    create index(:projects, [:category_id])
  end
end
