defmodule BirdiyWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias Absinthe.Relay.Node.ParseIDs
  alias Birdiy.{Accounts, Diy, Timeline}
  alias BirdiyWeb.Resolvers

  alias BirdiyWeb.Schema.Middleware.{
    Authorize,
    ParseRecord,
    AuthUser,
    ValidateUser
  }

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

  import_types(Absinthe.Plug.Types)
  import_types(__MODULE__.SessionTypes)
  import_types(__MODULE__.AccountsTypes)
  import_types(__MODULE__.DiyTypes)
  import_types(__MODULE__.TimelineTypes)

  node interface do
    resolve_type(fn
      %Accounts.User{}, _ ->
        :user

      %Diy.Project{}, _ ->
        :project

      %Diy.ProjectTopic{}, _ ->
        :project_topic

      %Diy.ProjectCategory{}, _ ->
        :project_category

      %Diy.ProjectComment{}, _ ->
        :project_comment

      %Timeline.Post{}, _ ->
        :post

      %Timeline.Activity{}, _ ->
        :activity

      _, _ ->
        nil
    end)
  end

  connection(node_type: :user)
  connection(node_type: :project)
  connection(node_type: :project_topic)
  connection(node_type: :project_category)
  connection(node_type: :project_comment)
  connection(node_type: :post)
  connection(node_type: :activity)

  query do
    node field do
      resolve(fn
        %{type: :user, id: local_id}, _ ->
          {:ok, Accounts.get_user!(local_id)}

        %{type: :project, id: local_id}, _ ->
          {:ok, Diy.get_project!(local_id)}

        %{type: :project_topic, id: local_id}, _ ->
          {:ok, Diy.get_project_topic!(local_id)}

        %{type: :project_category, id: local_id}, _ ->
          {:ok, Diy.get_project_category!(local_id)}

        %{type: :post, id: local_id}, _ ->
          {:ok, Timeline.get_post!(local_id)}

        _, _ ->
          {:error, "Unknown node"}
      end)
    end

    field :viewer, :viewer do
      middleware(Authorize)
      resolve(&Resolvers.Accounts.viewer/2)
    end

    field :user, :user do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :user)
      middleware(ParseRecord, id: {:user, Accounts.User})
      resolve(&Resolvers.Accounts.user/3)
    end

    connection field :all_project_categories, node_type: :project_category do
      arg(:order, type: :rank_order, default_value: :name)

      resolve(&Resolvers.Diy.project_categories/2)
    end

    connection field :all_projects, node_type: :project do
      arg(:filter, :project_filter)
      arg(:order, type: :project_order, default_value: :newest)

      resolve(&Resolvers.Diy.projects/3)
    end

    field :project, :project do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :project)
      resolve(&Resolvers.Diy.project/3)
    end

    field :project_comment, :project_comment do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :project_comment)
      resolve(&Resolvers.Diy.project_comment/3)
    end

    connection field :all_posts, node_type: :post do
      arg(:order, type: :post_order, default_value: :newest)

      resolve(&Resolvers.Timeline.posts/2)
    end

    field :post, :post do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :post)
      resolve(&Resolvers.Timeline.post/3)
    end

    connection field :all_activities, node_type: :activity do
      arg(:order, type: :activity_order, default_value: :newest)

      resolve(&Resolvers.Timeline.activities/2)
    end
  end

  mutation do
    field :login, :session do
      arg(:input, non_null(:login_input))

      resolve(&Resolvers.Session.login/3)
    end

    field :refresh_session, :session do
      arg(:input, non_null(:refresh_session_input))

      resolve(&Resolvers.Session.refresh_session/3)
    end

    field :edit_viewer, :viewer_result do
      arg(:input, non_null(:edit_user_input))

      middleware(Authorize)
      middleware(ValidateUser)
      resolve(&Resolvers.Accounts.edit_viewer/3)
    end

    field :follow_user, :follow_user_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ParseIDs, input: [id: :user])
      resolve(&Resolvers.Accounts.follow_user/3)
    end

    field :cancel_follow_user, :follow_user_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ParseIDs, input: [id: :user])
      resolve(&Resolvers.Accounts.cancel_follow_user/3)
    end

    field :create_project, :project_result do
      arg(:input, non_null(:create_project_input))

      middleware(Authorize)
      middleware(ValidateUser)
      resolve(&Resolvers.Diy.create_project/3)
    end

    field :edit_project, :project_result do
      arg(:input, non_null(:edit_project_input))

      middleware(Authorize)
      middleware(ValidateUser)

      middleware(ParseIDs,
        input: [
          id: :project,
          materials: [id: :project_material],
          file_resources: [id: :project_file_resource],
          methods: [id: :project_method]
        ]
      )

      middleware(ParseRecord, input: [id: {:project, Diy.Project}])
      middleware(AuthUser, input: [project: :author_id])
      resolve(&Resolvers.Diy.edit_project/3)
    end

    field :edit_and_publish_project, :project_result do
      arg(:input, non_null(:edit_project_input))

      middleware(Authorize)
      middleware(ValidateUser)

      middleware(ParseIDs,
        input: [
          id: :project,
          materials: [id: :project_material],
          file_resources: [id: :project_file_resource],
          methods: [id: :project_method]
        ]
      )

      middleware(ParseRecord, input: [id: {:project, Diy.Project}])
      middleware(AuthUser, input: [project: :author_id])
      resolve(&Resolvers.Diy.edit_and_publish_project/3)
    end

    field :create_project_comment, :project_comment_result do
      arg(:input, non_null(:create_project_comment_input))

      middle(Authorize)
      middleware(ValidateUser)

      middleware(ParseIDs,
        input: [
          project_id: :project,
          parent_id: :project_comment
        ]
      )

      resolve(&Resolvers.Diy.create_project_comment/3)
    end

    field :edit_project_comment, :project_comment_result do
      arg(:input, non_null(:edit_project_comment_input))

      middle(Authorize)
      middleware(ValidateUser)

      middleware(ParseIDs, input: [id: :project_comment])
      middleware(ParseRecord, input: [id: {:project_comment, Diy.ProjectComment}])
      middleware(AuthUser, input: [project_comment: :user_id])
      resolve(&Resolvers.Diy.edit_project_comment/3)
    end

    field :delete_project_comment, :project_comment_result do
      arg(:input, non_null(:id_input))

      middle(Authorize)
      middleware(ValidateUser)

      middleware(ParseIDs, input: [id: :project_comment])
      middleware(ParseRecord, input: [id: {:project_comment, Diy.ProjectComment}])
      middleware(AuthUser, input: [project_comment: :user_id])
      resolve(&Resolvers.Diy.delete_project_comment/3)
    end

    field :report_project_comment, :report_result do
      arg(:input, non_null(:id_input))

      middleware(ParseIDs, input: [id: :project_comment])
      resolve(&Resolvers.Diy.report_project_comment/3)
    end

    field :view_project, :project_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ParseIDs, input: [id: :project])
      resolve(&Resolvers.Accounts.view_project/3)
    end

    field :report_project, :report_result do
      arg(:input, non_null(:id_input))

      middleware(ParseIDs, input: [id: :project])
      resolve(&Resolvers.Diy.report_project/3)
    end

    field :like_project, :project_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ParseIDs, input: [id: :project])
      resolve(&Resolvers.Accounts.like_project/3)
    end

    field :cancel_like_project, :project_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ParseIDs, input: [id: :project])
      resolve(&Resolvers.Accounts.cancel_like_project/3)
    end

    field :favorite_project, :project_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ParseIDs, input: [id: :project])
      resolve(&Resolvers.Accounts.favorite_project/3)
    end

    field :cancel_favorite_project, :project_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ParseIDs, input: [id: :project])
      resolve(&Resolvers.Accounts.cancel_favorite_project/3)
    end

    field :delete_project, :project_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ValidateUser)
      middleware(ParseIDs, input: [id: :project])
      middleware(ParseRecord, input: [id: {:project, Diy.Project}])
      middleware(AuthUser, input: [project: :author_id])
      resolve(&Resolvers.Diy.delete_project/3)
    end

    field :publish_project, :project_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ValidateUser)
      middleware(ParseIDs, input: [id: :project])
      middleware(ParseRecord, input: [id: {:project, Diy.Project}])
      middleware(AuthUser, input: [project: :author_id])
      resolve(&Resolvers.Diy.publish_project/3)
    end

    field :unpublish_project, :project_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ValidateUser)
      middleware(ParseIDs, input: [id: :project])
      middleware(ParseRecord, input: [id: {:project, Diy.Project}])
      middleware(AuthUser, input: [project: :author_id])
      resolve(&Resolvers.Diy.unpublish_project/3)
    end

    field :create_post, :post_result do
      arg(:input, non_null(:create_post_input))

      middleware(Authorize)
      middleware(ValidateUser)
      middleware(ParseIDs, input: [related_project_id: :project])
      resolve(&Resolvers.Timeline.create_post/3)
    end

    field :edit_post, :post_result do
      arg(:input, non_null(:edit_post_input))

      middleware(Authorize)
      middleware(ValidateUser)

      middleware(ParseIDs,
        input: [
          id: :post,
          related_project_id: :project,
          photos: [id: :post_photo]
        ]
      )

      middleware(ParseRecord, input: [id: {:post, Timeline.Post}])
      middleware(AuthUser, input: [post: :author_id])
      resolve(&Resolvers.Timeline.edit_post/3)
    end

    field :delete_post, :post_result do
      arg(:input, non_null(:id_input))

      middleware(Authorize)
      middleware(ValidateUser)
      middleware(ParseIDs, input: [id: :post])
      middleware(ParseRecord, input: [id: {:post, Timeline.Post}])
      middleware(AuthUser, input: [post: :author_id])
      resolve(&Resolvers.Timeline.delete_post/3)
    end

    field :report_post, :report_result do
      arg(:input, non_null(:id_input))

      middleware(ParseIDs, input: [id: :post])
      resolve(&Resolvers.Timeline.report_post/3)
    end
  end

  object :report_result do
    field :reported, non_null(:boolean)
  end

  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

  input_object :id_input do
    field :id, non_null(:id)
  end

  scalar :datetime do
    parse(fn input ->
      case NaiveDateTime.from_iso8601(input.value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date ->
      date
      |> DateTime.from_naive!("Etc/UTC")
      |> DateTime.to_unix()
    end)
  end

  enum :rank_order do
    value(:name)
    value(:inserted_at)
  end

  enum :result do
    value(:ok)
    value(:error)
  end
end
