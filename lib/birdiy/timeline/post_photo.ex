defmodule Birdiy.Timeline.PostPhoto do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  import Birdiy.Ecto.Changeset

  alias Birdiy.{Timeline, PostPhoto}

  schema "post_photos" do
    field(:_destroy, :boolean, virtual: true)
    field :image, PostPhoto.Type
    field :order, :decimal
    belongs_to :post, Timeline.Post

    soft_delete_schema()
    timestamps()
  end

  @doc false
  def changeset(post_photo), do: changeset(post_photo, %{})

  @doc false
  def changeset(post_photo, attrs) do
    attrs =
      attrs
      |> put_random_filename([:image])
      |> decode_base64_image([:image])

    post_photo
    |> cast(attrs, [:_destroy, :order, :post_id])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image, :order])
    |> assoc_constraint(:post)
    |> mark_for_deletion()
  end

  defp mark_for_deletion(changeset) do
    if get_change(changeset, :_destroy) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
