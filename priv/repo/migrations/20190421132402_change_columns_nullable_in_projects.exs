defmodule Birdiy.Repo.Migrations.ChangeColumnsNullableInProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      modify :image, :string, null: true
      modify :introduction, :text, null: true
    end
  end
end
