defmodule Birdiy.Diy do
  @moduledoc """
  The Diy context.
  """

  import Ecto.Query, warn: false
  alias Birdiy.Repo

  alias Birdiy.Diy.ProjectCategory

  @doc """
  Returns the list of project_categories.

  ## Examples

      iex> list_project_categories()
      [%ProjectCategory{}, ...]

  """
  def list_project_categories do
    Repo.all(ProjectCategory)
  end

  @doc """
  Gets a single project_category.

  Raises `Ecto.NoResultsError` if the Project category does not exist.

  ## Examples

      iex> get_project_category!(123)
      %ProjectCategory{}

      iex> get_project_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project_category!(id), do: Repo.get!(ProjectCategory, id)

  @doc """
  Creates a project_category.

  ## Examples

      iex> create_project_category(%{field: value})
      {:ok, %ProjectCategory{}}

      iex> create_project_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project_category(attrs \\ %{}) do
    %ProjectCategory{}
    |> ProjectCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project_category.

  ## Examples

      iex> update_project_category(project_category, %{field: new_value})
      {:ok, %ProjectCategory{}}

      iex> update_project_category(project_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project_category(%ProjectCategory{} = project_category, attrs) do
    project_category
    |> ProjectCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProjectCategory.

  ## Examples

      iex> delete_project_category(project_category)
      {:ok, %ProjectCategory{}}

      iex> delete_project_category(project_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project_category(%ProjectCategory{} = project_category) do
    Repo.delete(project_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project_category changes.

  ## Examples

      iex> change_project_category(project_category)
      %Ecto.Changeset{source: %ProjectCategory{}}

  """
  def change_project_category(%ProjectCategory{} = project_category) do
    ProjectCategory.changeset(project_category, %{})
  end

  alias Birdiy.Diy.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{source: %Project{}}

  """
  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end

  alias Birdiy.Diy.ProjectMaterial

  @doc """
  Returns the list of project_materials.

  ## Examples

      iex> list_project_materials()
      [%ProjectMaterial{}, ...]

  """
  def list_project_materials do
    Repo.all(ProjectMaterial)
  end

  @doc """
  Gets a single project_material.

  Raises `Ecto.NoResultsError` if the Project material does not exist.

  ## Examples

      iex> get_project_material!(123)
      %ProjectMaterial{}

      iex> get_project_material!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project_material!(id), do: Repo.get!(ProjectMaterial, id)

  @doc """
  Creates a project_material.

  ## Examples

      iex> create_project_material(%{field: value})
      {:ok, %ProjectMaterial{}}

      iex> create_project_material(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project_material(attrs \\ %{}) do
    %ProjectMaterial{}
    |> ProjectMaterial.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project_material.

  ## Examples

      iex> update_project_material(project_material, %{field: new_value})
      {:ok, %ProjectMaterial{}}

      iex> update_project_material(project_material, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project_material(%ProjectMaterial{} = project_material, attrs) do
    project_material
    |> ProjectMaterial.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProjectMaterial.

  ## Examples

      iex> delete_project_material(project_material)
      {:ok, %ProjectMaterial{}}

      iex> delete_project_material(project_material)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project_material(%ProjectMaterial{} = project_material) do
    Repo.delete(project_material)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project_material changes.

  ## Examples

      iex> change_project_material(project_material)
      %Ecto.Changeset{source: %ProjectMaterial{}}

  """
  def change_project_material(%ProjectMaterial{} = project_material) do
    ProjectMaterial.changeset(project_material, %{})
  end

  alias Birdiy.Diy.ProjectFileResource

  @doc """
  Returns the list of project_file_resources.

  ## Examples

      iex> list_project_file_resources()
      [%ProjectFileResource{}, ...]

  """
  def list_project_file_resources do
    Repo.all(ProjectFileResource)
  end

  @doc """
  Gets a single project_file_resource.

  Raises `Ecto.NoResultsError` if the Project file resource does not exist.

  ## Examples

      iex> get_project_file_resource!(123)
      %ProjectFileResource{}

      iex> get_project_file_resource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project_file_resource!(id), do: Repo.get!(ProjectFileResource, id)

  @doc """
  Creates a project_file_resource.

  ## Examples

      iex> create_project_file_resource(%{field: value})
      {:ok, %ProjectFileResource{}}

      iex> create_project_file_resource(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project_file_resource(attrs \\ %{}) do
    %ProjectFileResource{}
    |> ProjectFileResource.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project_file_resource.

  ## Examples

      iex> update_project_file_resource(project_file_resource, %{field: new_value})
      {:ok, %ProjectFileResource{}}

      iex> update_project_file_resource(project_file_resource, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project_file_resource(%ProjectFileResource{} = project_file_resource, attrs) do
    project_file_resource
    |> ProjectFileResource.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProjectFileResource.

  ## Examples

      iex> delete_project_file_resource(project_file_resource)
      {:ok, %ProjectFileResource{}}

      iex> delete_project_file_resource(project_file_resource)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project_file_resource(%ProjectFileResource{} = project_file_resource) do
    Repo.delete(project_file_resource)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project_file_resource changes.

  ## Examples

      iex> change_project_file_resource(project_file_resource)
      %Ecto.Changeset{source: %ProjectFileResource{}}

  """
  def change_project_file_resource(%ProjectFileResource{} = project_file_resource) do
    ProjectFileResource.changeset(project_file_resource, %{})
  end

  alias Birdiy.Diy.ProjectMethod

  @doc """
  Returns the list of project_methods.

  ## Examples

      iex> list_project_methods()
      [%ProjectMethod{}, ...]

  """
  def list_project_methods do
    Repo.all(ProjectMethod)
  end

  @doc """
  Gets a single project_method.

  Raises `Ecto.NoResultsError` if the Project method does not exist.

  ## Examples

      iex> get_project_method!(123)
      %ProjectMethod{}

      iex> get_project_method!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project_method!(id), do: Repo.get!(ProjectMethod, id)

  @doc """
  Creates a project_method.

  ## Examples

      iex> create_project_method(%{field: value})
      {:ok, %ProjectMethod{}}

      iex> create_project_method(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project_method(attrs \\ %{}) do
    %ProjectMethod{}
    |> ProjectMethod.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project_method.

  ## Examples

      iex> update_project_method(project_method, %{field: new_value})
      {:ok, %ProjectMethod{}}

      iex> update_project_method(project_method, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project_method(%ProjectMethod{} = project_method, attrs) do
    project_method
    |> ProjectMethod.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProjectMethod.

  ## Examples

      iex> delete_project_method(project_method)
      {:ok, %ProjectMethod{}}

      iex> delete_project_method(project_method)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project_method(%ProjectMethod{} = project_method) do
    Repo.delete(project_method)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project_method changes.

  ## Examples

      iex> change_project_method(project_method)
      %Ecto.Changeset{source: %ProjectMethod{}}

  """
  def change_project_method(%ProjectMethod{} = project_method) do
    ProjectMethod.changeset(project_method, %{})
  end
end
