defmodule Birdiy.Diy.Project do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  import Ecto.SoftDelete.Query
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Accounts, Diy, Timeline, ProjectPhoto}

  schema "projects" do
    field :introduction, :string
    field :name, :string
    field :tip, :string
    field :image, ProjectPhoto.Type
    field :published_at, :date
    belongs_to :author, Accounts.User
    belongs_to :category, Diy.ProjectCategory
    has_many :materials, Diy.ProjectMaterial, where: [deleted_at: nil]
    has_many :file_resources, Diy.ProjectFileResource, where: [deleted_at: nil]
    has_many :methods, Diy.ProjectMethod, where: [deleted_at: nil]

    has_many :related_posts,
             Timeline.Post,
             foreign_key: :related_project_id,
             where: [deleted_at: nil]

    many_to_many :favorite_users,
                 Accounts.User,
                 join_through: "user_favorite_projects",
                 on_replace: :delete

    many_to_many :liked_users,
                 Accounts.User,
                 join_through: "user_liked_projects",
                 on_replace: :delete

    many_to_many :viewed_users,
                 Accounts.User,
                 join_through: "user_viewed_projects",
                 on_replace: :delete

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(project, author, attrs) do
    attrs = put_random_filename(attrs, [:image])

    project
    |> draft_changeset(author, attrs)
    |> cast(attrs, [:introduction, :tip])
    |> cast_attachments(attrs, [:image])
  end

  @doc false
  def draft_changeset(project, author, attrs) do
    project
    |> cast(attrs, [:name])
    |> put_change(:author_id, author.id)
    |> put_category(attrs[:category])
    |> validate_required([:author_id, :name, :category_id])
  end

  defp put_category(struct, category_name) do
    case Diy.get_project_category_by_name!(category_name) do
      %Diy.ProjectCategory{id: id} ->
        put_change(struct, :category_id, id)

      _ ->
        struct
    end
  end
end
