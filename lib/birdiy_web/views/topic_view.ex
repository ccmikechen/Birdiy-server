defmodule BirdiyWeb.TopicView do
  use BirdiyWeb, :view

  def meta_attrs("show.html", conn, %{topic_name: topic_name}) do
    [
      %{name: "description", content: description(topic_name)},
      %{property: "og:site_name", content: "Birdiy"},
      %{property: "og:locale", content: "zh_TW"},
      %{property: "og:url", content: url(conn)},
      %{property: "og:title", content: title(topic_name)},
      %{property: "og:description", content: description(topic_name)},
      %{property: "og:image", content: image()},
      %{property: "og:image:width", content: "750"},
      %{property: "og:image:height", content: "259"},
      %{property: "fb:app_id", content: "595828547560598"},
      %{property: "al:android:app_name", content: "Birdiy"},
      %{property: "al:android:package", content: "com.birdiy.birdiy"}
    ]
  end

  def title("show.html", %{topic_name: topic_name}) do
    title(topic_name)
  end

  defp title(topic_name) do
    "「#{topic_name}」專案、作法 - DIY社群平台 - Birdiy"
  end

  defp description(topic_name) do
    "立即下載 Birdiy APP！探索#{topic_name}的相關專案與作法。"
  end

  defp image do
    "https://birdiy-space.sfo2.digitaloceanspaces.com/birdiy/brand.png"
  end
end
