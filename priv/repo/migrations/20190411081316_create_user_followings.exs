defmodule Birdiy.Repo.Migrations.CreateUserFollowings do
  use Ecto.Migration

  def change do
    create table(:user_followings) do
      add :following_id, references(:users, on_delete: :nothing), null: false
      add :followed_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:user_followings, [:following_id, :followed_id])
  end
end
