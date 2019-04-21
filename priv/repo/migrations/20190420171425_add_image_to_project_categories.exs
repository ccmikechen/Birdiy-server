defmodule Birdiy.Repo.Migrations.AddImageToProjectCategories do
  use Ecto.Migration

  def change do
    alter table(:project_categories) do
      add :image, :string
    end
  end
end
