defmodule BirdiyWeb.Schema.DiyTypes do
  use Absinthe.Schema.Notation

  alias BirdiyWeb.Resolvers

  object :project_category do
    field :name, non_null(:string)
  end

  object :project do
    field :introduction, :string
    field :name, non_null(:string)
    field :tip, :string

    field :author, non_null(:user) do
      resolve(&Resolvers.Diy.project_author/3)
    end

    field :category, non_null(:project_category) do
      resolve(&Resolvers.Diy.project_category/3)
    end
  end
end
