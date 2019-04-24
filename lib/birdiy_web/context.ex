defmodule BirdiyWeb.Context do
  @behaviour Plug

  import Plug.Conn

  alias Birdiy.{Repo, Accounts}

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(_conn) do
    %{current_user: Repo.get(Accounts.User, 1)}
  end
end
