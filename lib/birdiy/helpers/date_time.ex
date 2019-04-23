defmodule Birdiy.Helpers.DateTime do
  def utc_now do
    DateTime.truncate(DateTime.utc_now(), :second)
  end
end
