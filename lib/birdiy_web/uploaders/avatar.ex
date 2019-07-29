defmodule Birdiy.Avatar do
  use Arc.Definition
  use Arc.Ecto.Definition
  use Birdiy.Arc.Resolver

  @acl :public_read
  @versions [:original]

  def validate({file, _}) do
    ~w(.jpg .jpeg .png) |> Enum.member?(Path.extname(file.file_name))
  end

  def storage_dir(_, _) do
    "images/avatar/"
  end

  def s3_object_headers(_, {file, _}) do
    [content_type: MIME.from_path(file.file_name)]
  end

  def url_from(parent = %{image: %{file_name: file_name}}) do
    url({file_name, parent})
  end
end
