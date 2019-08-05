defmodule Birdiy.Diy.Project do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Repo, Accounts, Diy, Timeline, ProjectPhoto, Helpers}

  schema "projects" do
    field :introduction, :string, size: 2000
    field :name, :string, size: 100
    field :source, :string
    field :tip, :string, size: 1000
    field :image, ProjectPhoto.Type
    field :video, :string
    field :published_at, :utc_datetime
    belongs_to :author, Accounts.User
    belongs_to :topic, Diy.ProjectTopic
    has_one :activity, Timeline.Activity, on_delete: :delete_all

    has_many :materials,
             Diy.ProjectMaterial,
             where: [deleted_at: nil],
             on_replace: :delete,
             on_delete: :delete_all

    has_many :file_resources,
             Diy.ProjectFileResource,
             where: [deleted_at: nil],
             on_replace: :delete

    has_many :methods,
             Diy.ProjectMethod,
             where: [deleted_at: nil],
             on_replace: :delete,
             on_delete: :delete_all

    has_many :related_posts,
             Timeline.Post,
             foreign_key: :related_project_id,
             where: [deleted_at: nil],
             on_delete: :delete_all

    many_to_many :favorite_users,
                 Accounts.User,
                 join_through: "user_favorite_projects",
                 on_replace: :delete,
                 on_delete: :delete_all

    many_to_many :liked_users,
                 Accounts.User,
                 join_through: "user_liked_projects",
                 on_replace: :delete,
                 on_delete: :delete_all

    many_to_many :viewed_users,
                 Accounts.User,
                 join_through: "user_viewed_projects",
                 on_replace: :delete,
                 on_delete: :delete_all

    has_many :views, Diy.ProjectView

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def published_changeset(project, attrs) do
    project
    |> changeset(attrs)
    |> validate_methods(project)
    |> validate_required([:image, :introduction])
  end

  @doc false
  def changeset(project, attrs) do
    attrs =
      attrs
      |> put_random_filename([:image])
      |> decode_base64_image([:image])

    project
    |> draft_changeset(attrs)
    |> cast(attrs, [:introduction, :tip, :source, :video])
    |> validate_length(:introduction, max: 300)
    |> validate_length(:tip, max: 300)
    |> cast_attachments(attrs, [:image])
    |> cast_assoc(:topic)
    |> cast_assoc(:materials)
    |> cast_assoc(:file_resources)
    |> cast_assoc(:methods)
  end

  @doc false
  def draft_changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :author_id, :topic_id])
    |> put_topic(attrs[:topic_name])
    |> assoc_constraint(:topic)
    |> validate_length(:name, max: 100)
    |> validate_required([:name])
    |> assoc_constraint(:author)
  end

  @doc false
  def publish_changeset(project) do
    attrs = %{published_at: Helpers.DateTime.utc_now()}

    project
    |> cast(attrs, [:published_at])
    |> validate_required([:published_at])
  end

  defp put_topic(struct, nil), do: struct

  defp put_topic(struct, topic_name) do
    case Diy.get_project_topic_by_name(topic_name) do
      %Diy.ProjectTopic{id: id} ->
        put_change(struct, :topic_id, id)

      _ ->
        add_error(struct, :topic_name, "not exists")
    end
  end

  defp validate_methods(changeset, project) do
    count = Ecto.assoc(project, :methods) |> Repo.aggregate(:count, :id)

    cond do
      count > 0 -> changeset
      true -> add_error(changeset, :methods, "Can't be empty")
    end
  end
end
