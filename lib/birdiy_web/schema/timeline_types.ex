defmodule BirdiyWeb.Schema.TimelineTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias BirdiyWeb.Resolvers
  alias Birdiy.PostPhoto

  enum :post_order do
    value(:newest)
  end

  node object(:post_photo) do
    field :image, non_null(:string), resolve: PostPhoto.resolver(:image)
    field :order, non_null(:integer)

    field :post, non_null(:post) do
      resolve(&Resolvers.Timeline.photo_post/3)
    end
  end

  node object(:post) do
    field :message, :string
    field :related_project_name, :string
    field :related_project_type, non_null(:string)

    field :author, non_null(:user) do
      resolve(&Resolvers.Timeline.post_author/3)
    end

    field :related_project, :project do
      resolve(&Resolvers.Timeline.post_related_project/3)
    end

    field :photos, list_of(:post_photo) do
      resolve(&Resolvers.Timeline.photos_for_post/3)
    end

    field :photos_count, :integer do
      resolve(&Resolvers.Timeline.photos_count_for_post/3)
    end

    field :thumbnail, :post_photo do
      resolve(&Resolvers.Timeline.thumbnail_for_post/3)
    end

    field :inserted_at, :datetime
  end

  input_object :post_input do
    field :id, non_null(:id)
  end

  input_object :create_post_input do
    field :related_project_type, non_null(:related_project_type)
    field :related_project_id, :id
    field :related_project_name, :string
    field :message, non_null(:string)
    field :photos, list_of(:post_photo_input)
  end

  input_object :edit_post_input do
    field :id, non_null(:id)
    field :related_project_type, non_null(:related_project_type)
    field :related_project_id, :id
    field :related_project_name, :string
    field :message, non_null(:string)
    field :photos, list_of(:post_photo_input)
  end

  input_object :post_photo_input do
    field :id, :id
    field :image, :upload
    field :order, non_null(:integer)
  end

  object :post_result do
    field :post, non_null(:post)
  end

  enum :related_project_type do
    value(:custom)
    value(:project)
  end
end
