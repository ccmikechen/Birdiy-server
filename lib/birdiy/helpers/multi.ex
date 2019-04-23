defmodule Birdiy.Helpers.Multi do
  alias Ecto.Multi
  alias Birdiy.Helpers.DateTime

  def soft_delete_all(multi, name, queryable) do
    Multi.update_all(multi, name, queryable, set: [deleted_at: DateTime.utc_now()])
  end
end
