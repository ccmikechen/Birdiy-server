defmodule Birdiy.Repo.Migrations.ChangeImageNullableInProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      modify :image, :string, null: true, default: nil
    end
  end
end
