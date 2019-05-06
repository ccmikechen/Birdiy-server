defmodule BirdiyWeb.Resolvers.Session do
  alias Birdiy.{Repo, Accounts}
  alias BirdiyWeb.Errors

  def login(_, %{input: params}, _) do
    with {:ok, user} <- Accounts.get_or_create_user_by(params.method, params.credential),
         {:ok, access_token, refresh_token} <- BirdiyWeb.Auth.sign(user) do
      {:ok, %{access_token: access_token, refresh_token: refresh_token, user: user}}
    else
      _ -> Errors.invalid_credential()
    end
  end

  def refresh_session(_, %{input: params}, _) do
    case BirdiyWeb.Auth.refresh_access_token(params.refresh_token) do
      {:ok, access_token} ->
        {:ok, %{access_token: access_token}}

      _ ->
        Errors.invalid_credential()
    end
  end
end
