defmodule Birdiy.Diy.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias Birdiy.{Accounts, Diy, Timeline}

  schema "projects" do
    field :introduction, :string
    field :name, :string
    field :tip, :string
    field :image, :string
    belongs_to :author, Accounts.User
    belongs_to :category, Diy.ProjectCategory
    has_many :materials, Diy.ProjectMaterial
    has_many :file_resources, Diy.ProjectFileResource
    has_many :methods, Diy.ProjectMethod
    has_many :related_posts, Timeline.Post, foreign_key: :related_project_id

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

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :introduction, :tip, :image])
    |> validate_required([:name, :author, :category, :image])
  end
end
