defmodule Birdiy.Diy.ProjectFileResource do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Diy, ProjectFile}

  schema "project_file_resources" do
    field(:_destroy, :boolean, virtual: true)
    field :name, :string, size: 50
    field :url, :string
    field :file, ProjectFile.Type
    field :order, :decimal
    belongs_to :project, Diy.Project

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(project_file_resource), do: changeset(project_file_resource, %{})

  @doc false
  def changeset(project_file_resource, attrs) do
    attrs = put_random_filename(attrs, [:file])

    project_file_resource
    |> cast(attrs, [:_destroy, :name, :url, :order, :project_id])
    |> validate_required([:name, :order])
    |> cast_attachments(attrs, [:file])
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
