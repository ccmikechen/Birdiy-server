defmodule BirdiyWeb.ProjectView do
  use BirdiyWeb, :view

  alias Birdiy.{Diy, Accounts}

  def title("show.html", %{
        project: %Diy.Project{name: project_name, author: %Accounts.User{name: author_name}}
      }) do
    "#{project_name} by #{author_name} - Birdiy"
  end

  def source_host(%Diy.Project{source: source}) do
    URI.parse(source) |> Map.get(:host)
  end
end
