defmodule Birdiy.Diy do
  @moduledoc """
  The Diy context.
  """

  import Ecto.Query, warn: false

  alias Birdiy.Repo

  alias Birdiy.Diy.{
    ProjectCategory,
    Project,
    ProjectMaterial,
    ProjectFileResource,
    ProjectMethod
  }

  def list_project_categories do
    Repo.all(ProjectCategory)
  end

  def get_project_category!(id), do: Repo.get!(ProjectCategory, id)

  def create_project_category(attrs \\ %{}) do
    %ProjectCategory{}
    |> ProjectCategory.changeset(attrs)
    |> Repo.insert()
  end

  def update_project_category(%ProjectCategory{} = project_category, attrs) do
    project_category
    |> ProjectCategory.changeset(attrs)
    |> Repo.update()
  end

  def delete_project_category(%ProjectCategory{} = project_category) do
    Repo.delete(project_category)
  end

  def change_project_category(%ProjectCategory{} = project_category) do
    ProjectCategory.changeset(project_category, %{})
  end

  def list_projects do
    Repo.all(Project)
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end

  def list_project_materials do
    Repo.all(ProjectMaterial)
  end

  def get_project_material!(id), do: Repo.get!(ProjectMaterial, id)

  def create_project_material(attrs \\ %{}) do
    %ProjectMaterial{}
    |> ProjectMaterial.changeset(attrs)
    |> Repo.insert()
  end

  def update_project_material(%ProjectMaterial{} = project_material, attrs) do
    project_material
    |> ProjectMaterial.changeset(attrs)
    |> Repo.update()
  end

  def delete_project_material(%ProjectMaterial{} = project_material) do
    Repo.delete(project_material)
  end

  def change_project_material(%ProjectMaterial{} = project_material) do
    ProjectMaterial.changeset(project_material, %{})
  end

  def list_project_file_resources do
    Repo.all(ProjectFileResource)
  end

  def get_project_file_resource!(id), do: Repo.get!(ProjectFileResource, id)

  def create_project_file_resource(attrs \\ %{}) do
    %ProjectFileResource{}
    |> ProjectFileResource.changeset(attrs)
    |> Repo.insert()
  end

  def update_project_file_resource(%ProjectFileResource{} = project_file_resource, attrs) do
    project_file_resource
    |> ProjectFileResource.changeset(attrs)
    |> Repo.update()
  end

  def delete_project_file_resource(%ProjectFileResource{} = project_file_resource) do
    Repo.delete(project_file_resource)
  end

  def change_project_file_resource(%ProjectFileResource{} = project_file_resource) do
    ProjectFileResource.changeset(project_file_resource, %{})
  end

  def list_project_methods do
    Repo.all(ProjectMethod)
  end

  def get_project_method!(id), do: Repo.get!(ProjectMethod, id)

  def create_project_method(attrs \\ %{}) do
    %ProjectMethod{}
    |> ProjectMethod.changeset(attrs)
    |> Repo.insert()
  end

  def update_project_method(%ProjectMethod{} = project_method, attrs) do
    project_method
    |> ProjectMethod.changeset(attrs)
    |> Repo.update()
  end

  def delete_project_method(%ProjectMethod{} = project_method) do
    Repo.delete(project_method)
  end

  def change_project_method(%ProjectMethod{} = project_method) do
    ProjectMethod.changeset(project_method, %{})
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
