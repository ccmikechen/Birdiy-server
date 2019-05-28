defmodule Birdiy.Repo.Migrations.AddVideoToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :video, :string
    end
  end
end
