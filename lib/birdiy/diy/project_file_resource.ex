defmodule Birdiy.Diy.ProjectFileResource do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Diy, ProjectFile}

  schema "project_file_resources" do
    field :name, :string
    field :url, :string
    field :file, ProjectFile.Type
    field :order, :decimal
    belongs_to :project, Diy.Project

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(project_file_resource, attrs) do
    attrs = put_random_filename(attrs, [:file])

    project_file_resource
    |> cast(attrs, [:name, :url, :order, :project_id])
    |> validate_required([:name, :order, :project_id])
    |> cast_attachments(attrs, [:file])
  end
end
