defmodule BirdiyWeb.LayoutView do
  use BirdiyWeb, :view

  @description_length 75

  def meta_tags(attrs_list) do
    Enum.map(attrs_list, &meta_tag/1)
  end

  def meta_tag(attrs) do
    tag(:meta, Enum.into(attrs, []))
  end

  def description(str) do
    cond do
      String.length(str) <= @description_length -> str
      true -> "#{String.slice(str, 0, @description_length)}..."
    end
  end
end
