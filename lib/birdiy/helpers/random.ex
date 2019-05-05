defmodule Birdiy.Helpers.Random do
  def string(length) do
    :crypto.strong_rand_bytes(length) |> Base.encode64() |> binary_part(0, length)
  end

  def access_key do
    Ecto.UUID.generate() |> binary_part(0, 8)
  end
end
