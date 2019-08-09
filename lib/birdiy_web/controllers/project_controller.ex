defmodule BirdiyWeb.ProjectController do
  use BirdiyWeb, :controller

  import Ecto.Query

  alias Birdiy.{Repo, Diy}

  def show(%Plug.Conn{remote_ip: ip} = conn, %{"id" => id}) do
    case Diy.project_from_global_id(id) do
      {:ok, %Diy.Project{deleted_at: nil, published_at: %DateTime{}} = project} ->
        increase_project_view_count(ip, project.id)

        project =
          Repo.preload(project, [
            :author,
            :topic,
            materials: from(m in Diy.ProjectMaterial, order_by: m.order),
            file_resources: from(f in Diy.ProjectFileResource, order_by: f.order),
            methods: from(m in Diy.ProjectMethod, order_by: m.order)
          ])

        render(conn, "show.html",
          current_url: "https://birdiy.com" <> current_path(conn, %{}),
          project: project
        )

      _ ->
        redirect(conn, to: "/")
    end
  end

  defp increase_project_view_count(ip, project_id) do
    if !ConCache.get(:project_view, {ip, project_id}) do
      Diy.increase_project_view_count(project_id)
      ConCache.put(:project_view, {ip, project_id}, true)
    end
  end
end
