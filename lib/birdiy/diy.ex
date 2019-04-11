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
end
