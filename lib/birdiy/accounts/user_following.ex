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
    |> assoc_constraint(:following)
    |> assoc_constraint(:followed)
    |> unique_constraint(:followed_id)
  end
end
