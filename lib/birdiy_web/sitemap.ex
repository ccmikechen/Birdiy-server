defmodule BirdiyWeb.Sitemap do
  @google_ping_url "http://www.google.com/ping?sitemap=https://birdiy.com/sitemap.xml"
  @bing_ping_url "http://www.bing.com/ping?sitemap=https://birdiy.com/sitemap.xml"

  def ping_google do
    HTTPoison.get(@google_ping_url)
  end

  def ping_bing do
    HTTPoison.get(@bing_ping_url)
  end
end
