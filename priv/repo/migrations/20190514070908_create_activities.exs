defmodule Birdiy.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:activities, [:project_id])
    create unique_index(:activities, [:post_id])
  end
end
