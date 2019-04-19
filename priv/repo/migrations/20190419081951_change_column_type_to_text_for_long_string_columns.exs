defmodule Birdiy.Repo.Migrations.ChangeColumnTypeToTextForLongStringColumns do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      modify :introduction, :text, null: false
      modify :tip, :text
    end

    alter table(:project_methods) do
      modify :content, :text, null: false
    end

    alter table(:posts) do
      modify :message, :text, null: false
    end
  end
end
