defmodule BirdiyWeb.SearchView do
  use BirdiyWeb, :view

  def meta_attrs("show.html", conn, %{search_text: search_text}) do
    [
      %{name: "description", content: description(search_text)},
      %{property: "og:site_name", content: "Birdiy"},
      %{property: "og:locale", content: "zh_TW"},
      %{property: "og:url", content: url(conn)},
      %{property: "og:title", content: title(search_text)},
      %{property: "og:description", content: description(search_text)},
      %{property: "og:image", content: image()},
      %{property: "og:image:width", content: "750"},
      %{property: "og:image:height", content: "259"},
      %{property: "fb:app_id", content: "595828547560598"},
      %{property: "al:android:app_name", content: "Birdiy"},
      %{property: "al:android:package", content: "com.birdiy.birdiy"}
    ]
  end

  def title("show.html", %{search_text: search_text}) do
    title(search_text)
  end

  defp title(search_text) do
    "「#{search_text}」專案、作法 - DIY社群平台 - Birdiy"
  end

  defp description(search_text) do
    "立即下載 Birdiy APP！探索「#{search_text}」的專案與作法。"
  end

  defp image do
    "https://birdiy-space.sfo2.digitaloceanspaces.com/birdiy/brand.png"
  end
end
