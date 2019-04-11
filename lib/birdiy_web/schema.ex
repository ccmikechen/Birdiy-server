defmodule BirdiyWeb.Schema do
  use Absinthe.Schema

  alias BirdiyWeb.Resolvers

  import_types(__MODULE__.AccountsTypes)

  query do
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.users/3)
    end
  end
end
