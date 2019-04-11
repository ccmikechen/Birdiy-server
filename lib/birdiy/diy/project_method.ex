defmodule Birdiy.Diy.ProjectMethod do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_methods" do
    field :content, :string
    field :image, :string
    field :order, :decimal
    field :title, :string
    belongs_to :project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(project_method, attrs) do
    project_method
    |> cast(attrs, [:title, :image, :content, :order])
    |> validate_required([:content, :order, :project])
  end
end
