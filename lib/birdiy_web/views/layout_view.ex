defmodule BirdiyWeb.LayoutView do
  use BirdiyWeb, :view

  @description_length 75

  def default_title do
    "Birdiy - DIY社群平台 - 自己動手做，享受手作的樂趣！"
  end

  def meta_tags(attrs_list) do
    Enum.map(attrs_list, &tag(:meta, Enum.into(&1, [])))
  end
end
