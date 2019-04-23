defmodule Birdiy.Timeline.PostPhoto do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  schema "post_photos" do
    field :image, :string
    belongs_to :post, Birdiy.Timeline.Post

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(post_photo, attrs) do
    post_photo
    |> cast(attrs, [:image])
    |> validate_required([:image, :post])
  end
end
