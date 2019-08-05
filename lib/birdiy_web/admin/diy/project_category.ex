defmodule BirdiyWeb.Admin.Diy.ProjectCategory do
  use ExAdmin.Register

  register_resource Birdiy.Diy.ProjectCategory do
    show category do
      attributes_table do
        row(:id)
        row(:name)
        row(:image)
      end

      panel "Topics" do
        table_for category.topics do
          column(:name, fn topic ->
            ExAdmin.Utils.link_to(topic.name, "/admin/project_topics/#{topic.id}")
          end)
        end
      end
    end
  end
end
