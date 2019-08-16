defmodule Birdiy.Repo.Migrations.AddReportCountToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :report_count, :integer, null: false, default: 0
    end
  end
end
