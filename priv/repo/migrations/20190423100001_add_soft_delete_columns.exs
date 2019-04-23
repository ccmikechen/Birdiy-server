defmodule Birdiy.Repo.Migrations.AddSoftDeleteColumns do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    alter table(:projects) do
      soft_delete_columns()
    end

    alter table(:project_materials) do
      soft_delete_columns()
    end

    alter table(:project_file_resources) do
      soft_delete_columns()
    end

    alter table(:project_methods) do
      soft_delete_columns()
    end

    alter table(:posts) do
      soft_delete_columns()
    end

    alter table(:post_photos) do
      soft_delete_columns()
    end
  end
end
