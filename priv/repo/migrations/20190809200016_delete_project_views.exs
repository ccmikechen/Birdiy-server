defmodule Birdiy.Repo.Migrations.DeleteProjectViews do
  use Ecto.Migration

  def change do
    drop table(:project_views)
  end
end
