defmodule BirdiyWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias BirdiyWeb.Resolvers

  object :user do
    field :image, :string
    field :name, non_null(:string)

    connection field :projects, node_type: :project do
      resolve(&Resolvers.Diy.projects_for_user/2)
    end

    connection field :posts, node_type: :post do
      resolve(&Resolvers.Timeline.posts_for_user/2)
    end

    field :following_users, list_of(:user) do
      resolve(&Resolvers.Accounts.following_users/3)
    end

    connection field :following_user_posts, node_type: :post do
      resolve(&Resolvers.Accounts.following_user_posts/2)
    end

    field :followed_users, list_of(:user) do
      resolve(&Resolvers.Accounts.followed_users/3)
    end

    connection field :favorite_projects, node_type: :project do
      resolve(&Resolvers.Accounts.favorite_projects/2)
    end

    connection field :liked_projects, node_type: :project do
      resolve(&Resolvers.Accounts.liked_projects/2)
    end

    connection field :viewed_projects, node_type: :project do
      resolve(&Resolvers.Accounts.viewed_projects/2)
    end

    field :following_count, :integer do
      resolve(&Resolvers.Accounts.following_count/3)
    end

    field :followed_count, :integer do
      resolve(&Resolvers.Accounts.followed_count/3)
    end
  end
end
