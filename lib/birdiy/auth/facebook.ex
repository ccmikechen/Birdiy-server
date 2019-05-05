defmodule Birdiy.Auth.Facebook do
  def auth(token) do
    api = "https://graph.facebook.com/me?access_token=#{token}"

    with %HTTPoison.Response{body: body, status_code: 200} <- HTTPoison.get!(api),
         {:ok, %{"id" => id}} <- Jason.decode(body) do
      {:ok, id}
    else
      _ -> nil
    end
  end
end
