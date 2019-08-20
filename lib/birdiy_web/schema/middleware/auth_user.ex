defmodule BirdiyWeb.Schema.Middleware.AuthUser do
  @behaviour Absinthe.Middleware

  alias Absinthe.Resolution
  alias BirdiyWeb.Errors
  alias Birdiy.Accounts.User

  def call(%{context: %{current_user: %User{} = current_user}} = resolution, config) do
    arguments = resolution.arguments
    user_id = Map.get(current_user, :id)

    case auth(user_id, arguments, config) do
      :ok -> resolution
      :error -> Resolution.put_result(resolution, Errors.permission_denied())
    end
  end

  def call(resolution, _) do
    Resolution.put_result(resolution, Errors.unauthorized())
  end

  defp auth(user_id, arguments, [{arg_field, arg} | rest]) do
    children_arguments = arguments[arg_field]

    case auth(user_id, children_arguments, arg) do
      :ok -> auth(user_id, arguments, rest)
      :error -> :error
    end
  end

  defp auth(_, _, []) do
    :ok
  end

  defp auth(_, nil, _) do
    :error
  end

  defp auth(user_id, arg, field) do
    id = Map.get(arg, field)

    case user_id do
      ^id -> :ok
      _ -> :error
    end
  end
end
