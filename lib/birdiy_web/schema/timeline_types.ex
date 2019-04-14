defmodule BirdiyWeb.Schema.TimelineTypes do
  use Absinthe.Schema.Notation

  alias BirdiyWeb.Resolvers

  object :post_photo do
    field :image, non_null(:string)

    field :post, non_null(:post) do
      resolve(&Resolvers.Timeline.photo_post/3)
    end
  end

  object :post do
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

    field :thumbnail, :post_photo do
      resolve(&Resolvers.Timeline.thumbnail_for_post/3)
    end

    field :inserted_at, :datetime
  end
end
