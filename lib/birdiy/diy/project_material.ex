defmodule Birdiy.Diy.ProjectMaterial do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  schema "project_materials" do
    field :amount_unit, :string
    field :name, :string
    field :url, :string
    field :order, :decimal
    belongs_to :project, Birdiy.Diy.Project

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(project_material, attrs) do
    project_material
    |> cast(attrs, [:id, :name, :amount_unit, :url, :order, :project_id])
    |> validate_required([:name, :amount_unit, :order, :project_id])
  end
end
