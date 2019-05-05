defmodule Birdiy.Helpers.Random do
  def refresh_key do
    Ecto.UUID.generate() |> binary_part(0, 8)
  end
end
