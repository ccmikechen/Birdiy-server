defmodule BirdiyWeb.Auth do
  alias Birdiy.Guardian
  alias Birdiy.Accounts.User

  def sign(user) do
    {:ok, refresh_token, _} =
      Guardian.encode_and_sign(
        user,
        %{key: user.access_key},
        token_type: "refresh",
        ttl: {60, :days}
      )

    {:ok, access_token} = refresh_access_token(refresh_token)
    {:ok, access_token, refresh_token}
  end

  def verify(access_token) do
    Guardian.resource_from_token(access_token)
    |> case do
      {:ok, %User{access_key: key} = user, %{"key" => key, "typ" => "access"}} ->
        {:ok, user}

      _ ->
        nil
    end
  end

  def refresh_access_token(refresh_token) do
    Guardian.exchange(refresh_token, "refresh", "access", ttl: {60, :minutes})
    |> case do
      {:ok, _, {new_token, _}} ->
        {:ok, new_token}

      _ ->
        nil
    end
  end
end
