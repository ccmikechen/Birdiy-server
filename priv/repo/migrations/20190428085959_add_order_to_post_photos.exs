defmodule Birdiy.Repo.Migrations.AddOrderToPostPhotos do
  use Ecto.Migration

  def change do
    alter table(:post_photos) do
      add :order, :decimal, null: false, default: 0
    end
  end
end
