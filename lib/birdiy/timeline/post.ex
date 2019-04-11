defmodule Birdiy.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :message, :string
    field :related_project_name, :string
    field :related_project_type, :string
    belongs_to :author, Birdiy.Accounts.User
    belongs_to :related_project, Birdiy.Diy.Project

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:related_project_type, :related_project_name, :message])
    |> validate_required([:related_project_type])
  end
end
