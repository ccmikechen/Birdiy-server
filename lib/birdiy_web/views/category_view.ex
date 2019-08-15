defmodule BirdiyWeb.CategoryView do
  use BirdiyWeb, :view

  def meta_attrs("show.html", conn, %{category_name: category_name}) do
    [
      %{name: "description", content: description(category_name)},
      %{property: "og:site_name", content: "Birdiy"},
      %{property: "og:locale", content: "zh_TW"},
      %{property: "og:url", content: url(conn)},
      %{property: "og:title", content: title(category_name)},
      %{property: "og:description", content: description(category_name)},
      %{property: "og:image", content: image()},
      %{property: "og:image:width", content: "750"},
      %{property: "og:image:height", content: "259"},
      %{property: "fb:app_id", content: "595828547560598"},
      %{property: "al:android:app_name", content: "Birdiy"},
      %{property: "al:android:package", content: "com.birdiy.birdiy"}
    ]
  end

  def title("show.html", %{category_name: category_name}) do
    title(category_name)
  end

  defp title(category_name) do
    "「#{category_name}」專案、作法 - DIY社群平台 - Birdiy"
  end

  defp description(category_name) do
    "立即下載 Birdiy APP！探索#{category_name}類的專案與作法。"
  end

  defp image do
    "https://birdiy-space.sfo2.digitaloceanspaces.com/birdiy/brand.png"
  end
end
