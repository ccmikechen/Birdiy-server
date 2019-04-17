defmodule Birdiy.Repo.Migrations.AddImageToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :image, :string, null: false, default: ""
    end
  end
end
