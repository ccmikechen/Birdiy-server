defmodule BirdiyWeb.Admin.Timeline.Post do
  use ExAdmin.Register

  alias Birdiy.Repo
  alias Birdiy.Accounts.User
  alias Birdiy.Timeline.Post
  alias Birdiy.PostPhoto

  register_resource Post do
    index do
      selectable_column()

      column(:id, fn post ->
        ExAdmin.Utils.link_to(post.id, "/admin/posts/#{post.id}")
      end)

      column(:message)
      column(:author)

      column(:related_project, fn post ->
        case post.related_project_type do
          "project" ->
            ExAdmin.Utils.link_to(
              post.related_project.name,
              "/admin/projects/#{post.related_project_id}"
            )

          _ ->
            post.related_project_name
        end
      end)

      column(:inserted_at)
      column(:deleted_at)
    end

    show post do
      attributes_table do
        row(:id)
        row(:message)
        row(:author)
        row(:related_project_type)
        row(:related_project_name)
        row(:related_project)
        row(:inserted_at)
        row(:deleted_at)
      end

      panel "Photos" do
        sortable_table_for post, :photos do
          sort_handle_column()

          column(:id)
          column(:order)

          column(:image, fn photo ->
            img(
              src: PostPhoto.url_from(photo),
              style: "height: 180px; width: 240px"
            )
          end)
        end
      end
    end

    form post do
      inputs do
        input(post, :message, maxlength: 1000)

        input(post, :author,
          collection:
            if params[:id] do
              [post.author]
            else
              Repo.all(User)
            end
        )

        input(post, :related_project_id)
        input(post, :related_project_name)
      end

      inputs do
        has_many post, :photos, fn photo ->
          input(photo, :order)
          input(photo, :image, type: :image, aspect: 4 / 3)
        end
      end
    end
  end
end
