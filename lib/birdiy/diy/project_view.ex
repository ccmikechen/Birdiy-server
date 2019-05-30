defmodule Birdiy.Diy.ProjectView do
  use Ecto.Schema

  import Ecto.Changeset

  schema "project_views" do
    field :ip, :string
    belongs_to :project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(project_view, attrs) do
    project_view
    |> cast(attrs, [:ip, :project_id])
    |> validate_required([:ip, :project_id])
    |> unique_constraint(:project_id)
  end
end
