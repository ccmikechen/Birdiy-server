defmodule BirdiyWeb.SearchView do
  use BirdiyWeb, :view

  def title("show.html", %{search_text: search_text}) do
    "「#{search_text}」專案、作法 - DIY社群平台 - Birdiy"
  end
end
