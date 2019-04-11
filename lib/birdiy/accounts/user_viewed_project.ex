defmodule Birdiy.Accounts.UserViewedProject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_viewed_projects" do
    belongs_to :user, Birdiy.Accounts.User
    belongs_to :project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(user_viewed_project, attrs) do
    user_viewed_project
    |> validate_required([:user, :project])
    |> unique_constraint([:user, :project])
  end
end