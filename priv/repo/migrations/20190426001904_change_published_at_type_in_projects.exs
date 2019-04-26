defmodule Birdiy.Repo.Migrations.ChangePublishedAtTypeInProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      modify :published_at, :utc_datetime
    end
  end
end
