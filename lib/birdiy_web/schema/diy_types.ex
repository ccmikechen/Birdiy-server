defmodule BirdiyWeb.Schema.DiyTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias BirdiyWeb.Resolvers

  node object(:project_category) do
    field :name, non_null(:string)
    field :image, :string

    field :projects, list_of(:project) do
      resolve(&Resolvers.Diy.projects_for_category/3)
    end
  end

  object :project_material do
    field :amount_unit, non_null(:string)
    field :name, non_null(:string)
    field :url, :string
    field :order, non_null(:integer)

    field :project, :project do
      resolve(&Resolvers.Diy.material_project/3)
    end
  end

  object :project_file_resource do
    field :name, non_null(:string)
    field :url, non_null(:string)
    field :order, non_null(:integer)

    field :project, :project do
      resolve(&Resolvers.Diy.file_resource_project/3)
    end
  end

  object :project_method do
    field :title, :string
    field :content, non_null(:string)
    field :image, :string
    field :order, non_null(:integer)

    field :project, :project do
      resolve(&Resolvers.Diy.method_project/3)
    end
  end

  input_object :project_filter do
    field :name, :string
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
    field :image, non_null(:string)

    field :author, non_null(:user) do
      resolve(&Resolvers.Diy.project_author/3)
    end

    field :category, non_null(:project_category) do
      resolve(&Resolvers.Diy.project_category/3)
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
end
