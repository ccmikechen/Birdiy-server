defmodule Birdiy.Diy.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias Birdiy.{Accounts, Diy, Timeline}

  schema "projects" do
    field :introduction, :string
    field :name, :string
    field :tip, :string
    belongs_to :author, Accounts.User
    belongs_to :category, Diy.ProjectCategory
    has_many :materials, Diy.ProjectMaterial
    has_many :file_resources, Diy.ProjectFileResource
    has_many :methods, Diy.ProjectMethod
    has_many :related_posts, Timeline.Post, foreign_key: :related_project_id

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :introduction, :tip])
    |> validate_required([:name, :author, :category])
  end
end
