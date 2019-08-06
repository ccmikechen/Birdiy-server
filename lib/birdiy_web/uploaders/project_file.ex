defmodule Birdiy.ProjectFile do
  use Arc.Definition
  use Arc.Ecto.Definition
  use Birdiy.Arc.Resolver

  @acl :public_read
  @versions [:original]

  def storage_dir(_, _) do
    "files/project"
  end

  def s3_object_headers(_, {file, scope}) do
    filename = scope.name
    ext = Path.extname(filename)
    origin_ext = Path.extname(file.file_name)

    filename =
      case ext do
        ^origin_ext -> filename
        _ -> "#{filename}#{origin_ext}"
      end

    [
      content_type: MIME.from_path(file.file_name),
      content_disposition: "attachment; filename=\"#{filename}\""
    ]
  end

  def url_from(%{file: nil, url: url}) do
    url
  end

  def url_from(file = %{file: %{file_name: file_name}}) do
    url({file_name, file})
  end

  def url_from(_) do
    nil
  end
end
