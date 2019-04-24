defmodule Birdiy.Accounts.UserLikedProject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_liked_projects" do
    belongs_to :user, Birdiy.Accounts.User
    belongs_to :project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(user_liked_project, attrs) do
    user_liked_project
    |> cast(attrs, [])
    |> validate_required([:user, :project])
    |> unique_constraint([:user, :project])
  end
end
