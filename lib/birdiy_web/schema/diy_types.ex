defmodule BirdiyWeb.Schema.DiyTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias BirdiyWeb.Resolvers
  alias Birdiy.ProjectPhoto

  node object(:project_category) do
    field :name, non_null(:string)
    field :image, :string

    connection field :topics, node_type: :project_topic do
      arg(:order, type: :rank_order, default_value: :name)

      resolve(&Resolvers.Diy.topics_for_category/3)
    end

    connection field :projects, node_type: :project do
      arg(:filter, :project_filter)
      arg(:order, type: :project_order, default_value: :newest)

      resolve(&Resolvers.Diy.projects/3)
    end
  end

  node object(:project_topic) do
    field :name, non_null(:string)

    field :category, non_null(:project_category) do
      resolve(&Resolvers.Diy.topic_category/3)
    end

    connection field :projects, node_type: :project do
      arg(:filter, :project_filter)
      arg(:order, type: :project_order, default_value: :newest)

      resolve(&Resolvers.Diy.projects/3)
    end
  end

  node object(:project_material) do
    field :amount_unit, non_null(:string)
    field :name, non_null(:string)
    field :url, :string
    field :order, non_null(:integer)

    field :project, :project do
      resolve(&Resolvers.Diy.material_project/3)
    end
  end

  node object(:project_file_resource) do
    field :name, non_null(:string)

    field :url, non_null(:string) do
      resolve(&Resolvers.Diy.file_resource_url/3)
    end

    field :order, non_null(:integer)

    field :type, :string do
      resolve(&Resolvers.Diy.file_resource_type/3)
    end

    field :project, :project do
      resolve(&Resolvers.Diy.file_resource_project/3)
    end
  end

  node object(:project_method) do
    field :title, :string
    field :content, non_null(:string)
    field :image, :string, resolve: ProjectPhoto.resolver(:image)
    field :order, non_null(:integer)

    field :project, :project do
      resolve(&Resolvers.Diy.method_project/3)
    end
  end

  input_object :project_filter do
    field :name, :string
    field :topics, list_of(:string)
    field :categories, list_of(:string)
  end

  enum :project_order do
    value(:newest)
    value(:hotest)
  end

  node object(:project) do
    field :introduction, :string
    field :name, non_null(:string)
    field :tip, :string
    field :image, :string, resolve: ProjectPhoto.resolver(:image)
    field :video, :string
    field :published_at, :datetime
    field :deleted_at, :datetime

    field :published, :boolean do
      resolve(&Resolvers.Diy.project_published/3)
    end

    field :viewed, :boolean do
      resolve(&Resolvers.Diy.project_viewed/3)
    end

    field :liked, :boolean do
      resolve(&Resolvers.Diy.project_liked/3)
    end

    field :favorite, :boolean do
      resolve(&Resolvers.Diy.project_favorite/3)
    end

    field :author, non_null(:user) do
      resolve(&Resolvers.Diy.project_author/3)
    end

    field :topic, non_null(:project_topic) do
      resolve(&Resolvers.Diy.project_topic/3)
    end

    field :materials, list_of(:project_material) do
      resolve(&Resolvers.Diy.materials_for_project/3)
    end

    field :file_resources, list_of(:project_file_resource) do
      resolve(&Resolvers.Diy.file_resources_for_project/3)
    end

    field :methods, list_of(:project_method) do
      resolve(&Resolvers.Diy.methods_for_project/3)
    end

    connection field :related_posts, node_type: :post do
      resolve(&Resolvers.Diy.related_posts_for_project/2)
    end

    field :related_post_count, :integer do
      resolve(&Resolvers.Diy.project_related_post_count/3)
    end

    field :view_count, :integer do
      resolve(&Resolvers.Diy.project_view_count/3)
    end

    field :favorite_count, :integer do
      resolve(&Resolvers.Diy.project_favorite_count/3)
    end

    field :like_count, :integer do
      resolve(&Resolvers.Diy.project_like_count/3)
    end
  end

  input_object :project_input do
    field :id, non_null(:id)
  end

  input_object :create_project_input do
    field :name, non_null(:string)
    field :topic, non_null(:string)
  end

  input_object :edit_project_input do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :topic, non_null(:string)
    field :introduction, :string
    field :tip, :string
    field :image, :upload
    field :video, :string
    field :publish, :boolean
    field :materials, list_of(:project_material_input)
    field :file_resources, list_of(:project_file_resource_input)
    field :methods, list_of(:project_method_input)
  end

  object :project_result do
    field :project, non_null(:project)
  end

  input_object :project_material_input do
    field :id, :id
    field :amount_unit, non_null(:string)
    field :name, non_null(:string)
    field :url, :string
    field :order, non_null(:integer)
  end

  input_object :project_file_resource_input do
    field :id, :id
    field :name, non_null(:string)
    field :url, :string
    field :file, :upload
    field :order, non_null(:integer)
  end

  input_object :project_method_input do
    field :id, :id
    field :title, :string
    field :content, non_null(:string)
    field :image, :upload
    field :order, :integer
  end
end
