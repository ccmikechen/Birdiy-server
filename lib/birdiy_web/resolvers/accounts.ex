defmodule BirdiyWeb.Resolvers.Accounts do
  alias Birdiy.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end
end
