defmodule Birdiy.Diy.ProjectFileResource do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  schema "project_file_resources" do
    field :name, :string
    field :url, :string
    field :order, :decimal
    belongs_to :project, Birdiy.Diy.Project

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(project_file_resource, attrs) do
    project_file_resource
    |> cast(attrs, [:name, :url, :order])
    |> validate_required([:name, :url, :order, :project])
  end
end
