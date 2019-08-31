defmodule BirdiyWeb.Schema.Middleware.ValidateUser do
  @behaviour Absinthe.Middleware

  alias Absinthe.Resolution
  alias BirdiyWeb.Errors
  alias Birdiy.Accounts.User

  def call(%{context: %{current_user: %User{} = current_user}} = resolution, _config) do
    case Map.get(current_user, :banned_at) do
      nil -> resolution
      _ -> Resolution.put_result(resolution, Errors.banned())
    end
  end

  def call(resolution, _) do
    Resolution.put_result(resolution, Errors.unauthorized())
  end
end
