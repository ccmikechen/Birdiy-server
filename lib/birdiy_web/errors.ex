defmodule BirdiyWeb.Errors do
  def permission_denied do
    {:error, code: 1, message: "Permission denied"}
  end

  def record_not_found do
    {:error, code: 2, message: "Record is not found"}
  end
end
