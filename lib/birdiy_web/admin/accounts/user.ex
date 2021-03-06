defmodule BirdiyWeb.Admin.Accounts.User do
  use ExAdmin.Register

  register_resource Birdiy.Accounts.User do
    index do
      selectable_column()

      column(:id)

      column(:name, fn user ->
        ExAdmin.Utils.link_to(user.name, "/admin/users/#{user.id}")
      end)

      column(:image, fn user ->
        img(
          src: Birdiy.Avatar.url_from(user),
          style: "height: 50px; width: 50px; border-radius: 25px"
        )
      end)

      column(:facebook_id)
      column(:google_id)
      column(:inserted_at)
      column(:banned_at)
      actions()
    end

    show user do
      attributes_table do
        row(:id)
        row(:name)

        row(:image, fn user ->
          img(src: Birdiy.Avatar.url_from(user), style: "height: 200px; width: 200px")
        end)

        row(:facebook_id)
        row(:google_id)
        row(:banned_at)
      end

      panel "Projects" do
        table_for user.projects do
          column(:image, fn project ->
            img(src: Birdiy.ProjectPhoto.url_from(project), style: "height: 60px; width: 80px")
          end)

          column(:name, fn project ->
            cond do
              String.length(project.name) > 20 ->
                String.slice(project.name, 0..20) <> "..."

              true ->
                project.name
            end
            |> ExAdmin.Utils.link_to("/admin/projects/#{project.id}")
          end)

          column(:topic)
          column(:published_at)
          column(:inserted_at)
          column(:deleted_at)
        end
      end

      panel "Posts" do
        table_for user.posts do
          column(:id, fn post ->
            ExAdmin.Utils.link_to(post.id, "/admin/posts/#{post.id}")
          end)

          column(:message)
          column(:related_project)
          column(:related_project_name)
          column(:inserted_at)
          column(:deleted_at)
        end
      end
    end

    form user do
      inputs do
        input(user, :name, maxlength: 100)
        input(user, :image, type: :image, aspect: 1)
        input(user, :facebook_id)
        input(user, :google_id)
        input(user, :banned_at)
      end
    end

    query do
      %{show: [preload: [projects: :topic, posts: :related_project]]}
    end
  end
end
