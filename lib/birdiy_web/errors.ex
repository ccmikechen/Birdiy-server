defmodule BirdiyWeb.Errors do
  def permission_denied do
    {:error, code: 1, message: "Permission denied"}
  end

  def record_not_found do
    {:error, code: 2, message: "Record is not found"}
  end

  def create_project do
    {:error, code: 2001, message: "Can't create project"}
  end

  def update_project do
    {:error, code: 2002, message: "Can't update project"}
  end

  def delete_project do
    {:error, code: 2003, message: "Can't delete project"}
  end

  def publish_project do
    {:error, code: 2004, message: "Can't publish project"}
  end

  def unpublish_project do
    {:error, code: 2005, message: "Can't unpublish project"}
  end

  def create_post do
    {:error, code: 3001, message: "Can't create post"}
  end

  def update_post do
    {:error, code: 3002, message: "Can't update post"}
  end
end
