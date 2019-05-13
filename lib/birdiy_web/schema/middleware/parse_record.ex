defmodule BirdiyWeb.Schema.Middleware.ParseRecord do
  @behaviour Absinthe.Middleware

  alias Birdiy.Repo

  def call(resolution, config) do
    arguments = resolution.arguments
    result = config |> Enum.map(&parse(arguments, &1)) |> Map.new()

    %{resolution | arguments: DeepMerge.deep_merge(arguments, result)}
  end

  defp parse(arguments, {id_field, {result_field, struct}}) do
    id = arguments[id_field]

    case id && Repo.get(struct, id) do
      nil -> {result_field, nil}
      record -> {result_field, record}
    end
  end

  defp parse(arguments, {parent, args}) do
    children_arguments = arguments[parent]
    children = args |> Enum.map(&parse(children_arguments, &1)) |> Map.new()
    {parent, children}
  end
end
