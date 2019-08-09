defmodule BirdiyWeb.HomeView do
  use BirdiyWeb, :view

  def meta_attrs(_, conn, _assigns) do
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
      %{property: "al:android:package", content: "com.birdiy.birdiy"},
      %{property: "twitter:card", content: "summary_large_image"},
      %{property: "twitter:title", content: title()},
      %{property: "twitter:description", content: description()},
      %{property: "twitter:image", content: image()}
    ]
  end

  def title(_, _assigns), do: title()

  defp title do
    "Birdiy - DIY社群平台 - 自己動手做，享受手作的樂趣！"
  end

  defp description do
    "台灣DIY社群平台，探索有趣的DIY專案，分享你的手作知識，激發你的創作靈感！加入這個DIY社群，幾十種主題等你逛，讓你的手作靈感源源不絕。照著圖文步驟做，磨練你的手作技能，分享製作成果，假日休閒不浪費！"
  end

  defp image do
    "https://birdiy-space.sfo2.digitaloceanspaces.com/birdiy/brand.png"
  end
end
