defmodule BirdiyWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias Absinthe.Relay.Node.ParseIDs
  alias Birdiy.{Accounts, Diy, Timeline, Repo}
  alias BirdiyWeb.Resolvers

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  def dataloader do
    Dataloader.new()
    |> Dataloader.add_source(Diy, Diy.data())
    |> Dataloader.add_source(Timeline, Timeline.data())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

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

  connection(node_type: :project)
  connection(node_type: :post)

  query do
    node field do
      resolve(fn
        %{type: :user, id: local_id}, _ ->
          {:ok, Accounts.get_user!(local_id)}

        %{type: :prject, id: local_id}, _ ->
          {:ok, Diy.get_project!(local_id)}

        %{type: :post, id: local_id}, _ ->
          {:ok, Timeline.get_post!(local_id)}

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

    connection field :all_projects, node_type: :project do
      resolve(&Resolvers.Diy.projects/2)
    end

    field :project, :project do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :project)
      resolve(&Resolvers.Diy.project/3)
    end

    connection field :all_posts, node_type: :post do
      resolve(&Resolvers.Timeline.posts/2)
    end

    field :post, :post do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :post)
      resolve(&Resolvers.Timeline.post/3)
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
