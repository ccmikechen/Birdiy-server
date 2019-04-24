defmodule Birdiy.Diy.ProjectMethod do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Diy, ProjectPhoto}

  schema "project_methods" do
    field :content, :string
    field :image, ProjectPhoto.Type
    field :order, :decimal
    field :title, :string
    belongs_to :project, Diy.Project

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(project_method, attrs) do
    attrs = put_random_filename(attrs, [:image])

    project_method
    |> cast(attrs, [:title, :content, :order, :project_id])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:content, :order, :project_id])
  end
end
