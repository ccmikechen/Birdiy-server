defmodule BirdiyWeb.DownloadView do
  use BirdiyWeb, :view

  def meta_attrs("index.html", conn, _assigns) do
    [
      %{name: "description", content: description()},
      %{property: "og:site_name", content: "Birdiy"},
      %{property: "og:locale", content: "zh_TW"},
      %{property: "og:url", content: url(conn)},
      %{property: "og:title", content: title()},
      %{property: "og:description", content: description()},
      %{property: "og:image", content: image()},
      %{property: "og:image:width", content: "750"},
      %{property: "og:image:height", content: "259"},
      %{property: "fb:app_id", content: "595828547560598"},
      %{property: "al:android:app_name", content: "Birdiy"},
      %{property: "al:android:package", content: "com.birdiy.birdiy"}
    ]
  end

  def title(_, _assigns), do: title()

  defp title do
    "下載APP - DIY社群平台 - Birdiy"
  end

  defp description do
    "立即下載 Birdiy APP！探索更多 DIY 專案與作法。"
  end

  defp image do
    "https://birdiy-space.sfo2.digitaloceanspaces.com/birdiy/brand.png"
  end
end
