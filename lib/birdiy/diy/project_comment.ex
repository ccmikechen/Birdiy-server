defmodule Birdiy.Diy.ProjectComment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Birdiy.{Accounts, Diy}

  schema "project_comments" do
    field :message, :string, size: 500
    field :report_count, :integer, default: 0
    belongs_to :project, Diy.Project
    belongs_to :user, Accounts.User
    belongs_to :parent, Diy.ProjectComment

    has_many :replies,
             Diy.ProjectComment,
             foreign_key: :parent_id,
             on_replace: :delete,
             on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(project_comment, attrs) do
    project_comment
    |> cast(attrs, [:message, :project_id, :user_id, :parent_id])
    |> assoc_constraint(:project)
    |> assoc_constraint(:user)
    |> assoc_constraint(:parent)
    |> validate_required([:message])
  end
end
