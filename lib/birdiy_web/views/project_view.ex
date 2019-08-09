defmodule BirdiyWeb.ProjectView do
  use BirdiyWeb, :view

  alias Birdiy.{Diy, Accounts}

  def meta_attrs("show.html", conn, %{project: project}) do
    [
      %{name: "author", content: project.author.name},
      %{name: "description", content: desc(project.introduction)},
      %{property: "og:site_name", content: "Birdiy"},
      %{property: "og:locale", content: "zh_TW"},
      %{property: "og:url", content: url(conn)},
      %{property: "og:title", content: "#{project.name} by #{project.author.name} - Birdiy"},
      %{property: "og:type", content: "article"},
      %{property: "og:description", content: desc(project.introduction)},
      %{property: "og:image", content: Diy.project_image_url(project)},
      %{property: "og:image:width", content: "700"},
      %{property: "og:image:height", content: "525"},
      %{property: "fb:app_id", content: "595828547560598"},
      %{property: "al:android:app_name", content: "Birdiy"},
      %{property: "al:android:package", content: "com.birdiy.birdiy"},
      %{property: "twitter:card", content: "summary_large_image"},
      %{property: "twitter:title", content: project.name},
      %{property: "twitter:description", content: desc(project.introduction)},
      %{property: "twitter:image", content: Diy.project_image_url(project)}
    ]
  end

  def title("show.html", %{
        project: %Diy.Project{name: project_name, author: %Accounts.User{name: author_name}}
      }) do
    "#{project_name} by #{author_name} - Birdiy"
  end

  def source_host(%Diy.Project{source: source}) do
    URI.parse(source) |> Map.get(:host)
  end

  def avatar_alt(%Diy.Project{author: %Accounts.User{name: author_name}}) do
    String.first(author_name)
  end
end
