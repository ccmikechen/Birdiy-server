defmodule Birdiy.Repo.Migrations.ChangeProjectsCategoryToTopic do
  use Ecto.Migration

  def change do
    drop index(:projects, [:category_id])

    alter table(:projects) do
      remove :category_id
      add :topic_id, references(:project_topics, on_delete: :nothing), null: false, default: 1
    end

    create index(:projects, [:topic_id])
  end
end
