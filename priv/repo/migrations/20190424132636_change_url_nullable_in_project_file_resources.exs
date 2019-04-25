defmodule Birdiy.Repo.Migrations.ChangeUrlNullableInProjectFileResources do
  use Ecto.Migration

  def change do
    alter table(:project_file_resources) do
      modify :url, :string, null: true
    end
  end
end
