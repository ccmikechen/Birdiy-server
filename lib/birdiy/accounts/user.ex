defmodule Birdiy.Accounts.User do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Accounts, Diy, Timeline, Avatar}
  alias Birdiy.Helpers.Random

  schema "users" do
    field :image, Avatar.Type
    field :name, :string, size: 20
    field :access_key, :string, size: 8
    field :facebook_id, :string
    field :google_id, :string
    field :banned_at, :utc_datetime

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
    attrs =
      attrs
      |> put_random_filename([:image])
      |> decode_base64_image([:image])

    user
    |> cast(attrs, [:name, :image, :facebook_id, :google_id, :banned_at])
    |> put_random_name()
    |> put_random_access_key()
    |> cast_attachments(attrs, [:image])
    |> validate_required([:name, :access_key])
    |> unique_constraint(:facebook_id)
    |> unique_constraint(:google_id)
  end

  defp put_random_name(changeset) do
    with %{changes: changes, data: %{name: nil}} <- changeset,
         nil <- changes[:name] do
      put_change(changeset, :name, Random.string(6))
    else
      _ -> changeset
    end
  end

  defp put_random_access_key(changeset) do
    with %{changes: changes, data: %{access_key: nil}} <- changeset,
         nil <- changes[:access_key] do
      put_change(changeset, :access_key, Random.access_key())
    else
      _ -> changeset
    end
  end
end
