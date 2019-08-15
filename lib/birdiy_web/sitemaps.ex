defmodule BirdiyWeb.Sitemaps do
  alias BirdiyWeb.{Endpoint, Router.Helpers}
  alias Birdiy.Diy

  use Sitemap,
    host: "https://#{Application.get_env(:birdiy, Endpoint)[:url][:host]}",
    files_path: "priv/static/sitemaps/",
    public_path: "sitemaps/"

  def generate do
    create do
      add("/", priority: 0.5, changefreq: "always", expires: nil)

      # Categories
      Diy.list_project_categories()
      |> Enum.each(fn category ->
        add(Helpers.search_path(Endpoint, :show, category.name),
          priority: 0.5,
          changefreq: "weekly",
          expires: nil
        )
      end)

      # Topics
      Diy.list_project_topics()
      |> Enum.each(fn topic ->
        add(Helpers.search_path(Endpoint, :show, topic.name),
          priority: 0.5,
          changefreq: "weekly",
          expires: nil
        )
      end)

      # Projects
      Diy.list_projects()
      |> Enum.each(fn project ->
        global_id = Absinthe.Relay.Node.to_global_id("Project", project.id)

        add(Helpers.project_path(Endpoint, :show, global_id),
          priority: 0.5,
          changefreq: "weekly",
          expires: nil
        )
      end)
    end

    ping()
  end
end
