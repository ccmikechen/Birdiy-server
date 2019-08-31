defmodule Birdiy.Repo.Migrations.CreateProjectComments do
  use Ecto.Migration

  def change do
    create table(:project_comments) do
      add :message, :string, null: false
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :parent_id, references(:project_comments, on_delete: :nothing)
      add :report_count, :integer, null: false, default: 0

      timestamps()
    end

    create index(:project_comments, [:project_id])
    create index(:project_comments, [:user_id])
    create index(:project_comments, [:parent_id])
  end
end
