defmodule Birdiy.Accounts.UserFavoriteProject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_favorite_projects" do
    belongs_to :user, Birdiy.Accounts.User
    belongs_to :project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(user_favorite_project, attrs) do
    user_favorite_project
    |> cast(attrs, [])
    |> validate_required([:user, :project])
    |> unique_constraint([:user, :project])
  end
end
