defmodule BirdiyWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias Birdiy.{Accounts, Diy, Timeline, Repo}
  alias BirdiyWeb.Resolvers

  import_types(__MODULE__.AccountsTypes)
  import_types(__MODULE__.DiyTypes)
  import_types(__MODULE__.TimelineTypes)

  node interface do
    resolve_type(fn
      %Accounts.User{}, _ ->
        :user

      %Diy.Project{}, _ ->
        :project

      %Timeline.Post{}, _ ->
        :post

      _, _ ->
        nil
    end)
  end

  connection(node_type: :post)

  query do
    node field do
      resolve(fn
        %{type: :user, id: local_id}, _ ->
          {:ok, Repo.get(Accounts.User, local_id)}

        %{type: :post, id: local_id}, _ ->
          {:ok, Repo.get(Timeline.Post, local_id)}

        _, _ ->
          {:error, "Unknown node"}
      end)
    end

    field :viewer, :user do
      resolve(&Resolvers.Accounts.viewer/2)
    end

    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.users/3)
    end

    field :projects, list_of(:project) do
      resolve(&Resolvers.Diy.projects/3)
    end

    connection field :all_posts, node_type: :post do
      resolve(&Resolvers.Timeline.posts/2)
    end
  end

  scalar :datetime do
    parse(fn input ->
      case NaiveDateTime.from_iso8601(input.value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date ->
      NaiveDateTime.to_iso8601(date)
    end)
  end
end
