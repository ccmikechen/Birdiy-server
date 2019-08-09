defmodule Birdiy.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  alias Birdiy.{Repo, Accounts, Diy, Timeline}

  schema "posts" do
    field :message, :string, size: 1000
    field :related_project_name, :string
    field :related_project_type, :string
    belongs_to :author, Accounts.User
    belongs_to :related_project, Diy.Project
    has_one :activity, Timeline.Activity, on_delete: :delete_all

    has_many :photos, Timeline.PostPhoto,
      where: [deleted_at: nil],
      on_replace: :delete,
      on_delete: :delete_all

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(post), do: changeset(post, %{})

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:author_id, :related_project_id, :related_project_name, :message])
    |> assoc_constraint(:author)
    |> assoc_constraint(:related_project)
    |> put_related_project_type()
    |> cast_assoc(:photos)
  end

  @doc false
  def update_changeset(post, attrs) do
    post
    |> changeset(attrs)
    |> validate_photos(post)
  end

  defp put_related_project_type(changeset) do
    cond do
      get_change(changeset, :related_project) ||
          get_change(changeset, :related_project_id) ->
        put_change(changeset, :related_project_type, "project")

      get_change(changeset, :related_project_name) ->
        put_change(changeset, :related_project_type, "custom")

      true ->
        changeset
    end
  end

  defp validate_photos(changeset, post) do
    count = Ecto.assoc(post, :photos) |> Repo.aggregate(:count, :id)

    cond do
      count > 0 -> changeset
      true -> add_error(changeset, :photos, "Can't be empty")
    end
  end
end
