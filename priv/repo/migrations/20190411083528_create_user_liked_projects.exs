defmodule Birdiy.Repo.Migrations.CreateUserLikedProjects do
  use Ecto.Migration

  def change do
    create table(:user_liked_projects) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :project_id, references(:projects, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:user_liked_projects, [:user_id, :project_id])
  end
end
