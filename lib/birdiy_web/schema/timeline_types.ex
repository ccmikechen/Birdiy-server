defmodule BirdiyWeb.Schema.TimelineTypes do
  use Absinthe.Schema.Notation

  alias BirdiyWeb.Resolvers

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
  end
end
