defmodule Birdiy.Ecto.Changeset do
  alias Plug.Upload

  def put_random_filename(params, fields) do
    Enum.reduce(fields, params, fn field, params ->
      image = random_filename(params[field])
      Map.put(params, field, image)
    end)
  end

  defp random_filename(%Upload{filename: filename} = field) do
    new_filename = UUID.uuid4(:hex) <> Path.extname(filename)
    %Upload{field | filename: new_filename}
  end

  defp random_filename(field) do
    field
  end
end
