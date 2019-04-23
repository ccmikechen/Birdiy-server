defmodule Birdiy.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  alias Birdiy.{Accounts, Diy, Timeline}

  schema "posts" do
    field :message, :string
    field :related_project_name, :string
    field :related_project_type, :string
    belongs_to :author, Accounts.User
    belongs_to :related_project, Diy.Project
    has_many :photos, Timeline.PostPhoto

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:related_project_type, :related_project_name, :message])
    |> validate_required([:related_project_type])
  end
end
