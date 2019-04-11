defmodule BirdiyWeb.Schema do
  use Absinthe.Schema

  alias BirdiyWeb.Resolvers

  import_types(__MODULE__.AccountsTypes)
  import_types(__MODULE__.DiyTypes)
  import_types(__MODULE__.TimelineTypes)

  query do
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.users/3)
    end

    field :projects, list_of(:project) do
      resolve(&Resolvers.Diy.projects/3)
    end

    field :posts, list_of(:post) do
      resolve(&Resolvers.Timeline.posts/3)
    end
  end
end
