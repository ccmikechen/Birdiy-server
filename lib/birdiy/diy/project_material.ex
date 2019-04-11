defmodule Birdiy.Diy.ProjectMaterial do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_materials" do
    field :amount_unit, :string
    field :name, :string
    field :url, :string
    field :order, :decimal
    belongs_to :project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(project_material, attrs) do
    project_material
    |> cast(attrs, [:name, :amountUnit, :url, :order])
    |> validate_required([:name, :amountUnit, :order, :project])
  end
end
