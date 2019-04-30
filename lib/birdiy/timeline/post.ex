defmodule Birdiy.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  alias Birdiy.{Repo, Accounts, Diy, Timeline}

  schema "posts" do
    field :message, :string
    field :related_project_name, :string
    field :related_project_type, :string
    belongs_to :author, Accounts.User
    belongs_to :related_project, Diy.Project
    has_many :photos, Timeline.PostPhoto, where: [deleted_at: nil]

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(post, author, attrs) do
    post
    |> cast(attrs, [:related_project_id, :related_project_name, :message])
    |> put_related_project_type(attrs)
    |> put_change(:author_id, author.id)
    |> validate_required([:related_project_type, :author_id])
  end

  @doc false
  def update_changeset(post, author, attrs) do
    post
    |> changeset(author, attrs)
    |> validate_photos(post)
  end

  defp put_related_project_type(changeset, attrs) do
    type =
      case attrs[:related_project_type] do
        :custom -> "custom"
        :project -> "project"
        _ -> nil
      end

    put_change(changeset, :related_project_type, type)
  end

  defp validate_photos(changeset, post) do
    count = Ecto.assoc(post, :photos) |> Repo.aggregate(:count, :id)

    cond do
      count > 0 -> changeset
      true -> add_error(changeset, :photos, "Can't be empty")
    end
  end
end
