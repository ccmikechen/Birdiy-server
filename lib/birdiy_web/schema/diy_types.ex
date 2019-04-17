defmodule BirdiyWeb.Schema.DiyTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias BirdiyWeb.Resolvers

  object :project_category do
    field :name, non_null(:string)

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

    field :related_posts, list_of(:post) do
      resolve(&Resolvers.Diy.related_posts_for_project/3)
    end
  end
end
