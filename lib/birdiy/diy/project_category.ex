defmodule Birdiy.Diy.ProjectCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_categories" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(project_category, attrs) do
    project_category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
