defmodule Birdiy.Repo.Migrations.CreateProjectCategories do
  use Ecto.Migration

  def change do
    create table(:project_categories) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
