defmodule Birdiy.Repo.Migrations.AddReportCountToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :report_count, :integer, null: false, default: 0
    end
  end
end
