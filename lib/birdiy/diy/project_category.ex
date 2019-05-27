defmodule Birdiy.Diy.ProjectCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias Birdiy.Diy

  schema "project_categories" do
    field :name, :string
    field :image, :string

    has_many :topics,
             Diy.ProjectTopic,
             foreign_key: :category_id

    timestamps()
  end

  @doc false
  def changeset(project_category, attrs) do
    project_category
    |> cast(attrs, [:name, :image])
    |> validate_required([:name])
  end
end
