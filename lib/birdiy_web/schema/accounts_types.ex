defmodule BirdiyWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :image, :string
    field :name, non_null(:string)
  end
end
