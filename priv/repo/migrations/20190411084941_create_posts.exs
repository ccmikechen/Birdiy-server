defmodule Birdiy.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :related_project_type, :string, null: false
      add :related_project_name, :string
      add :message, :string
      add :author_id, references(:users, on_delete: :nothing), null: false
      add :related_project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:author_id])
    create index(:posts, [:related_project_id])
  end
end
