defmodule Birdiy.Diy.ProjectFileResource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_file_resources" do
    field :name, :string
    field :url, :string
    belongs_to :project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(project_file_resource, attrs) do
    project_file_resource
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url, :project])
  end
end
