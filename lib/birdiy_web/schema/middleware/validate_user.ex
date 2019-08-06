defmodule BirdiyWeb.Schema.Middleware.ValidateUser do
  @behaviour Absinthe.Middleware

  alias Absinthe.Resolution
  alias BirdiyWeb.Errors

  def call(resolution, _config) do
    case Map.get(resolution.context[:current_user], :banned_at) do
      nil -> resolution
      _ -> Resolution.put_result(resolution, Errors.banned())
    end
  end
end
