defmodule BirdiyWeb.Schema.DiyTypes do
  use Absinthe.Schema.Notation

  import BirdiyWeb.Schema.AccountsTypes

  object :project_category do
    field :name, non_null(:string)
  end

  object :project do
    field :introduction, :string
    field :name, non_null(:string)
    field :tip, :string
    field :author, non_null(:user)
    field :category, non_null(:project_category)
  end
end
