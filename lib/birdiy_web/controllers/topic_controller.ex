defmodule BirdiyWeb.TopicController do
  use BirdiyWeb, :controller

  alias Birdiy.{Diy, Translation}

  def index(conn, _params) do
    redirect(conn, to: Routes.home_path(conn, :index))
  end

  def show(conn, %{"name" => name}) do
    topic_name = String.capitalize(name)

    case Diy.get_project_topic_by_name(topic_name) do
      %Diy.ProjectTopic{} = topic ->
        render(conn, "show.html",
          topic: topic,
          topic_name: Translation.topic(topic.name)
        )

      _ ->
        redirect(conn, to: Routes.home_path(conn, :index))
    end
  end
end
