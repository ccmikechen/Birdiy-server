defmodule BirdiyWeb.Schema.Helpers do
  use Absinthe.Schema.Notation

  import Ecto.Query

  alias Absinthe.Relay.Connection
  alias Birdiy.Repo

  def by_id(model, ids) do
    ids = ids |> Enum.uniq()

    model
    |> where([m], m.id in ^ids)
    |> Repo.all()
    |> Map.new(&{&1.id, &1})
  end

  def batch_by_id(model, id) do
    batch(
      {__MODULE__, :by_id, model},
      id,
      fn batch_results ->
        {:ok, Map.get(batch_results, id)}
      end
    )
  end

  def assoc(record, attr) do
    query = Ecto.assoc(record, attr)
    {:ok, Repo.all(query)}
  end

  def assoc_connection(record, attr, pagination_args) do
    Ecto.assoc(record, attr)
    |> Connection.from_query(&Repo.all/1, pagination_args)
  end
end
