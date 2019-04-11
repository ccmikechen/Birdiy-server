defmodule Birdiy.Accounts.UserFollowing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_followings" do
    belongs_to :following, Birdiy.Accounts.User
    belongs_to :followed, Birdiy.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(user_following, attrs) do
    user_following
    |> cast(attrs, [])
    |> validate_required([:following, :followed])
    |> unique_constraint([:following, :followed])
  end
end
