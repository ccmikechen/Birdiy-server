defmodule Birdiy.PostPhoto do
  use Arc.Definition
  use Arc.Ecto.Definition
  use Birdiy.Arc.Resolver

  @acl :public_read
  @versions [:original]

  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  def storage_dir(_, _) do
    "images/post/"
  end

  def s3_object_headers(_, {file, _}) do
    [content_type: MIME.from_path(file.file_name)]
  end
end
