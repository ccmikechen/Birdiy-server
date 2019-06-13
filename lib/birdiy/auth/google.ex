defmodule Birdiy.Auth.Google do
  def auth(token) do
    api = "https://www.googleapis.com/userinfo/v2/me"

    with %HTTPoison.Response{body: body, status_code: 200} <-
           HTTPoison.get!(api, [{"Authorization", "Bearer #{token}"}]),
         {:ok, %{"id" => id}} <- Jason.decode(body) do
      {:ok, id}
    else
      _ -> nil
    end
  end
end
