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
    |> cast(attrs, [:following_id, :followed_id])
    |> validate_required([:following_id, :followed_id])
    |> unique_constraint(:followed_id)
  end
end
