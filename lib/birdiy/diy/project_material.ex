defmodule Birdiy.Diy.ProjectMaterial do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  schema "project_materials" do
    field(:_destroy, :boolean, virtual: true)
    field :amount_unit, :string, size: 20
    field :name, :string, size: 50
    field :url, :string
    field :order, :decimal
    belongs_to :project, Birdiy.Diy.Project

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(project_material), do: changeset(project_material, %{})

  @doc false
  def changeset(project_material, attrs) do
    project_material
    |> cast(attrs, [:_destroy, :name, :amount_unit, :url, :order, :project_id, :deleted_at])
    |> validate_required([:name, :amount_unit, :order])
    |> assoc_constraint(:project)
    |> mark_for_deletion()
  end

  defp mark_for_deletion(changeset) do
    if get_change(changeset, :_destroy) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
