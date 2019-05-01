defmodule Birdiy.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Birdiy.{Accounts, Diy, Timeline}

  schema "users" do
    field :image, :string
    field :name, :string, size: 20

    has_many :projects,
             Diy.Project,
             foreign_key: :author_id,
             where: [deleted_at: nil]

    has_many :posts,
             Timeline.Post,
             foreign_key: :author_id,
             where: [deleted_at: nil]

    many_to_many :following_users,
                 Accounts.User,
                 join_through: "user_followings",
                 join_keys: [following_id: :id, followed_id: :id],
                 on_replace: :delete

    many_to_many :followed_users,
                 Accounts.User,
                 join_through: "user_followings",
                 join_keys: [followed_id: :id, following_id: :id],
                 on_replace: :delete

    many_to_many :favorite_projects,
                 Diy.Project,
                 where: [deleted_at: nil, published_at: {:not, nil}],
                 join_through: "user_favorite_projects",
                 on_replace: :delete

    many_to_many :liked_projects,
                 Diy.Project,
                 where: [deleted_at: nil, published_at: {:not, nil}],
                 join_through: "user_liked_projects",
                 on_replace: :delete

    many_to_many :viewed_projects,
                 Diy.Project,
                 where: [deleted_at: nil, published_at: {:not, nil}],
                 join_through: "user_viewed_projects",
                 on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :image])
    |> validate_required([:name])
  end
end
