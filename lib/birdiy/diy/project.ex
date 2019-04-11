defmodule Birdiy.Diy.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :introduction, :string
    field :name, :string
    field :tip, :string
    belongs_to :author, Birdiy.Accounts.User
    belongs_to :category, Birdiy.Diy.ProjectCategory

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :introduction, :tip])
    |> validate_required([:name, :author, :category])
  end
end
