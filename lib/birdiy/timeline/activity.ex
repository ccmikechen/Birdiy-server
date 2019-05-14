defmodule Birdiy.Timeline.Activity do
  use Ecto.Schema

  import Ecto.Changeset
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Diy, Timeline}

  schema "activities" do
    belongs_to :project, Diy.Project
    belongs_to :post, Timeline.Post

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:project_id, :post_id])
    |> validate_required_inclusion([:project_id, :post_id])
    |> unique_constraint(:project_id)
    |> unique_constraint(:post_id)
  end
end
