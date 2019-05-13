defmodule BirdiyWeb.Schema.Middleware.Authorize do
  @behaviour Absinthe.Middleware

  alias Absinthe.Resolution
  alias BirdiyWeb.Errors
  alias Birdiy.Accounts.User

  def call(resolution, _) do
    case resolution.context do
      %{current_user: %User{}} ->
        resolution

      _ ->
        Resolution.put_result(resolution, Errors.unauthorized())
    end
  end
end
