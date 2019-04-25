defmodule Birdiy.Repo.Migrations.AddFileToProjectFileResources do
  use Ecto.Migration

  def change do
    alter table(:project_file_resources) do
      add :file, :string
    end
  end
end
