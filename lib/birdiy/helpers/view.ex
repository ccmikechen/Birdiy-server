defmodule Birdiy.Helpers.View do
  def url(%Plug.Conn{scheme: scheme, host: host, port: port, request_path: path} = conn) do
    case conn do
      %{scheme: :http, port: 80} ->
        "#{scheme}://#{host}#{path}"

      %{scheme: :https, port: 443} ->
        "#{scheme}://#{host}#{path}"

      _ ->
        "#{scheme}://#{host}:#{port}#{path}"
    end
  end

  def desc(str) do
    cond do
      String.length(str) <= @description_length -> str
      true -> "#{String.slice(str, 0, @description_length)}..."
    end
  end
end
