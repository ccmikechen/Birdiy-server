defmodule BirdiyWeb.Context do
  @behaviour Plug

  import Plug.Conn

  alias BirdiyWeb.Auth

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Auth.verify(token) do
      %{current_user: data}
    else
      _ -> %{}
    end
  end
end
