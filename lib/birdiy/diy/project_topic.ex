defmodule Birdiy.Diy.ProjectTopic do
  use Ecto.Schema

  import Ecto.Changeset

  alias Birdiy.Diy

  schema "project_topics" do
    field :name, :string
    belongs_to :category, Diy.ProjectCategory

    has_many :projects,
             Diy.Project,
             foreign_key: :topic_id,
             where: [deleted_at: nil]

    timestamps()
  end

  @doc false
  def changeset(project_topic, attrs) do
    project_topic
    |> cast(attrs, [:name, :category_id])
    |> validate_required([:name, :category_id])
    |> unique_constraint(:name)
  end
end
