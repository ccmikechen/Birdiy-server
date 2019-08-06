defmodule Birdiy.Ecto.Changeset do
  import Ecto.Changeset

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
        %{} -> Map.put(params, field, image)
        _ -> params
      end
    end)
  end

  defp random_filename(%{filename: filename} = field) do
    new_filename = "#{UUID.uuid4(:hex)}#{Path.extname(filename)}"
    %{field | filename: new_filename}
  end

  defp random_filename(field) do
    field
  end

  def decode_base64_image(params, fields) do
    Enum.reduce(fields, params, fn field, params ->
      image = decode_base64(params[field])

      case image do
        %{} -> Map.put(params, field, image)
        _ -> params
      end
    end)
  end

  defp decode_base64(%{filename: filename, base64: "data:image/png;base64," <> base64}) do
    %{
      __struct__: Plug.Upload,
      binary: Base.decode64!(base64),
      filename: filename
    }
  end

  defp decode_base64(field) do
    field
  end
end
