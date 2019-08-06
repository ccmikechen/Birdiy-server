defmodule Birdiy.Diy.ProjectMethod do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Diy, ProjectPhoto}

  schema "project_methods" do
    field(:_destroy, :boolean, virtual: true)
    field :content, :string, size: 1000
    field :image, ProjectPhoto.Type
    field :order, :decimal
    field :title, :string, size: 50
    belongs_to :project, Diy.Project

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(project_method), do: changeset(project_method, %{})

  @doc false
  def changeset(project_method, attrs) do
    attrs =
      attrs
      |> put_random_filename([:image])
      |> decode_base64_image([:image])

    project_method
    |> cast(attrs, [:_destroy, :title, :content, :order, :project_id])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:content, :order])
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
