defmodule Birdiy.Ecto.Changeset do
  import Ecto.Changeset

  alias Plug.Upload

  def validate_required_inclusion(changeset, fields) do
    if Enum.any?(fields, &present?(changeset, &1)) do
      changeset
    else
      add_error(changeset, hd(fields), "One of these fields must be present: #{inspect(fields)}")
    end
  end

  defp present?(changeset, field) do
    value = get_field(changeset, field)
    value && value != ""
  end

  def put_random_filename(params, fields) do
    Enum.reduce(fields, params, fn field, params ->
      image = random_filename(params[field])

      case image do
        %Upload{} -> Map.put(params, field, image)
        _ -> params
      end
    end)
  end

  defp random_filename(%Upload{filename: filename} = field) do
    new_filename = "#{UUID.uuid4(:hex)}#{Path.extname(filename)}"
    %Upload{field | filename: new_filename}
  end

  defp random_filename(field) do
    field
  end
end
