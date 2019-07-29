defmodule BirdiyWeb.ProjectController do
  use BirdiyWeb, :controller

  import Ecto.Query

  alias Birdiy.{Repo, Diy}

  def show(conn, %{"id" => id}) do
    case Diy.project_from_global_id(id) do
      {:ok, project} ->
        project =
          Repo.preload(project, [
            :author,
            :topic,
            materials: from(m in Diy.ProjectMaterial, order_by: m.order),
            file_resources: from(f in Diy.ProjectFileResource, order_by: f.order),
            methods: from(m in Diy.ProjectMethod, order_by: m.order)
          ])

        attrs = [
          %{property: "og:title", content: "#{project.name} by #{project.author.name}"},
          %{property: "og:url", content: "https://birdiy.com/project/#{id}"},
          %{property: "og:type", content: "article"},
          %{property: "og:image", content: Diy.project_image_url(project)},
          %{property: "og:image:width", content: "1024"},
          %{property: "og:image:height", content: "768"},
          %{property: "twitter:card", content: "summary_large_image"},
          %{property: "twitter:title", content: project.name},
          %{property: "twitter:image", content: Diy.project_image_url(project)}
        ]

        render(conn, "show.html",
          project: project,
          description: project.introduction,
          meta_attrs: attrs
        )

      _ ->
        redirect(conn, to: "/")
    end
  end
end
