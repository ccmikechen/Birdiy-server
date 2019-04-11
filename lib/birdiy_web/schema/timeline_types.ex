defmodule BirdiyWeb.Schema.TimelineTypes do
  use Absinthe.Schema.Notation

  import BirdiyWeb.Schema.AccountsTypes
  import BirdiyWeb.Schema.DiyTypes

  object :post do
    field :message, :string
    field :related_project_name, :string
    field :related_project_type, non_null(:string)
    field :author, non_null(:user)
    field :related_project, :project
  end
end
