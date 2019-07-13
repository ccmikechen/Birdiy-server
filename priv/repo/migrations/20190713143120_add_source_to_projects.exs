defmodule Birdiy.Repo.Migrations.AddSourceToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :source, :string
    end
  end
end
