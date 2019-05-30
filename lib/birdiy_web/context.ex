defmodule BirdiyWeb.Context do
  @behaviour Plug

  import Plug.Conn

  alias BirdiyWeb.Auth

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn) |> put_remote_ip(conn)
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

  defp put_remote_ip(context, conn) do
    %{remote_ip: {a1, a2, a3, a4}} = conn
    Map.put(context, :remote_ip, "#{a1}.#{a2}.#{a3}.#{a4}")
  end
end
