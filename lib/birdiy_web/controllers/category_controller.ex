defmodule BirdiyWeb.CategoryController do
  use BirdiyWeb, :controller

  alias Birdiy.{Diy, Translation}

  def index(conn, _params) do
    redirect(conn, to: Routes.home_path(conn, :index))
  end

  def show(conn, %{"name" => name}) do
    category_name = String.capitalize(name)

    case Diy.get_project_category_by_name(category_name) do
      %Diy.ProjectCategory{} = category ->
        render(conn, "show.html",
          category: category,
          category_name: Translation.category(category.name)
        )

      _ ->
        redirect(conn, to: Routes.home_path(conn, :index))
    end
  end
end
