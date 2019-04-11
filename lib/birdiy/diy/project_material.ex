defmodule Birdiy.Diy.ProjectMaterial do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_materials" do
    field :amountUnit, :string
    field :name, :string
    field :url, :string
    belongs_to :project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(project_material, attrs) do
    project_material
    |> cast(attrs, [:name, :amountUnit, :url])
    |> validate_required([:name, :amountUnit, :project])
  end
end
