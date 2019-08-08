defmodule BirdiyWeb.Admin.Diy.Project do
  use ExAdmin.Register

  alias Birdiy.{Repo, ProjectPhoto, ProjectFile}
  alias Birdiy.Accounts.User

  alias Birdiy.Diy.{
    Project,
    ProjectTopic
  }

  register_resource Project do
    index do
      selectable_column()

      column(:image, fn project ->
        img(
          src: ProjectPhoto.url_from(project),
          style: "height: 60px; width: 80px"
        )
      end)

      column(:id)

      column(:name, fn project ->
        ExAdmin.Utils.link_to(project.name, "/admin/projects/#{project.id}")
      end)

      column(:topic)
      column(:author)
      column(:introduction)

      column(:video, fn project ->
        ExAdmin.Utils.link_to(project.video, project.video, target: "_blank")
      end)

      column(:source, fn project ->
        ExAdmin.Utils.link_to(project.source, project.source, target: "_blank")
      end)

      column(:tip)
      column(:inserted_at)
      column(:published_at)
      column(:deleted_at)
      actions()
    end

    show project do
      attributes_table do
        row(:image, fn project ->
          img(
            src: ProjectPhoto.url_from(project),
            style: "height: 240px; width: 320px"
          )
        end)

        row(:id)

        row(:global_id, fn project ->
          global_id = Absinthe.Relay.Node.to_global_id("Project", project.id)
          ExAdmin.Utils.link_to(global_id, "/project/#{global_id}", target: "_blank")
        end)

        row(:name)
        row(:topic)
        row(:author)
        row(:introduction)

        row(:video, fn project ->
          ExAdmin.Utils.link_to(project.video, project.video, target: "_blank")
        end)

        row(:source, fn project ->
          ExAdmin.Utils.link_to(project.source, project.source, target: "_blank")
        end)

        row(:tip)
        row(:inserted_at)
        row(:published_at)
        row(:deleted_at)
      end

      panel "Materials" do
        sortable_table_for project, :materials do
          sort_handle_column()

          column(:order)
          column(:name)
          column(:amount_unit)

          column(:url, fn material ->
            ExAdmin.Utils.link_to(material.url, material.url, target: "_blank")
          end)
        end
      end

      panel "File resources" do
        sortable_table_for project, :file_resources do
          sort_handle_column()

          column(:order)
          column(:name)

          column(:file, fn material ->
            ExAdmin.Utils.link_to(
              material.file[:file_name],
              ProjectFile.url_from(material),
              target: "_blank"
            )
          end)

          column(:url, fn material ->
            ExAdmin.Utils.link_to(material.url, material.url, target: "_blank")
          end)
        end
      end

      panel "Methods" do
        sortable_table_for project, :methods do
          sort_handle_column()

          column(:order)

          column(:image, fn method ->
            img(
              src: ProjectPhoto.url_from(method),
              style: "height: 180px; width: 240px"
            )
          end)

          column(:title)
          column(:content)
        end
      end

      panel "Related Posts" do
        sortable_table_for project, :related_posts do
          sort_handle_column()

          column(:id, fn post ->
            ExAdmin.Utils.link_to(post.id, "/admin/posts/#{post.id}")
          end)

          column(:message)
        end
      end
    end

    form project do
      inputs do
        input(project, :name, maxlength: 100)

        input(project, :author,
          collection:
            if params[:id] do
              [project.author]
            else
              Repo.all(User)
            end
        )

        input(project, :image, type: :image, aspect: 4 / 3)
        input(project, :topic, collection: Repo.all(ProjectTopic))
        input(project, :introduction, type: :text, maxlength: 2000, rows: 10)
        input(project, :video)
        input(project, :source)
        input(project, :tip, maxlength: 1000)
        input(project, :published_at)
        input(project, :deleted_at)
      end

      inputs "Materials" do
        has_many project, :materials, fn material ->
          input(material, :order)
          input(material, :name, maxlength: 50)
          input(material, :amount_unit, maxlength: 20)
          input(material, :url)
        end
      end

      inputs "File resources" do
        has_many project, :file_resources, fn file ->
          input(file, :order)
          input(file, :name, maxlength: 50)
          input(file, :file, type: :file)
          input(file, :url)
        end
      end

      inputs "Methods" do
        has_many project, :methods, fn method ->
          input(method, :order)
          input(method, :image, type: :image, aspect: 4 / 3)
          input(method, :title, maxlength: 50)
          input(method, :content, type: :text, maxlength: 1000)
        end
      end
    end
  end
end
