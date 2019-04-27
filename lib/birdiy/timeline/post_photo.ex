defmodule Birdiy.Timeline.PostPhoto do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Timeline, PostPhoto}

  schema "post_photos" do
    field :image, PostPhoto.Type
    belongs_to :post, Timeline.Post

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(post_photo, attrs) do
    attrs = put_random_filename(attrs, [:image])

    post_photo
    |> cast(attrs, [:post_id])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image, :post_id])
  end
end
