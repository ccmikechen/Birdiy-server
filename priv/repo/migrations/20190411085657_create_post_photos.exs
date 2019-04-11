defmodule Birdiy.Repo.Migrations.CreatePostPhotos do
  use Ecto.Migration

  def change do
    create table(:post_photos) do
      add :image, :string, null: false
      add :post_id, references(:posts, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:post_photos, [:post_id])
  end
end
