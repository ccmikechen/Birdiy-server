defmodule Birdiy.Diy do
  @moduledoc """
  The Diy context.
  """

  import Ecto.Query, warn: false
  import Ecto.SoftDelete.Query

  alias Ecto.Multi
  alias Birdiy.Repo

  alias Birdiy.Helpers

  alias Birdiy.Diy.{
    ProjectCategory,
    Project,
    ProjectMaterial,
    ProjectFileResource,
    ProjectMethod
  }

  alias Birdiy.Accounts.User

  def list_project_categories do
    Repo.all(ProjectCategory)
  end

  def project_categories_query(args) do
    Enum.reduce(args, ProjectCategory, fn
      {:order, order}, query ->
        query |> order_by(asc: ^order)

      _, query ->
        query
    end)
  end

  def get_project_category!(id), do: Repo.get!(ProjectCategory, id)

  def get_project_category_by_name!(name), do: Repo.get_by!(ProjectCategory, name: name)

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

  def list_projects do
    Repo.all(Project) |> with_undeleted()
  end

  def projects_query(args), do: projects_query(Project, args)

  def projects_query(query, args) do
    Enum.reduce(args, query, fn
      {:order, :newest}, query ->
        query |> order_by(desc: :inserted_at)

      {:filter, filter}, query ->
        query |> project_filter_with(filter)

      _, query ->
        query
    end)
    |> with_undeleted()
  end

  defp project_filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from(q in query, where: ilike(q.name, ^"%#{name}%"))

      {:categories, []}, query ->
        query

      {:categories, categories}, query ->
        from(q in query,
          join: c in assoc(q, :category),
          where: c.name in ^categories
        )
    end)
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def get_project_materials!(%Project{} = project) do
    Ecto.assoc(project, :materials)
    |> order_by(desc: :order)
    |> Repo.all()
  end

  def get_project_file_resources!(%Project{} = project) do
    Ecto.assoc(project, :file_resources)
    |> order_by(desc: :order)
    |> Repo.all()
  end

  def get_project_methods!(%Project{} = project) do
    Ecto.assoc(project, :methods)
    |> order_by(desc: :order)
    |> Repo.all()
  end

  def count_project_related_posts!(%Project{} = project) do
    Ecto.assoc(project, :related_posts)
    |> Repo.aggregate(:count, :id)
  end

  def count_project_views!(%Project{} = project) do
    Ecto.assoc(project, :viewed_users)
    |> Repo.aggregate(:count, :id)
  end

  def count_project_favorites!(%Project{} = project) do
    Ecto.assoc(project, :favorite_users)
    |> Repo.aggregate(:count, :id)
  end

  def count_project_likes!(%Project{} = project) do
    Ecto.assoc(project, :liked_users)
    |> Repo.aggregate(:count, :id)
  end

  def create_project(%User{} = author, attrs \\ %{}) do
    %Project{}
    |> Project.draft_changeset(author, attrs)
    |> Repo.insert()
  end

  def update_project(%Project{} = project, %User{} = author, attrs) do
    result =
      Multi.new()
      |> delete_project_materials_query(project)
      |> upsert_project_materials_query(project, attrs[:materials])
      |> update_project_query(project, author, attrs)
      |> Repo.transaction()

    with {:ok, %{update_project: project}} do
      {:ok, project}
    end
  end

  defp update_project_query(multi, %Project{} = project, %User{} = author, attrs) do
    changeset = Project.changeset(project, author, attrs)
    Multi.update(multi, :update_project, changeset)
  end

  def delete_project(%Project{} = project) do
    Repo.soft_delete(project)
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

  def upsert_project_materials(%Project{} = project, params) do
    Multi.new()
    |> delete_project_materials_query(project)
    |> upsert_project_materials_query(project, params)
    |> Repo.transaction()
  end

  defp upsert_project_materials_query(multi, %Project{} = project, params) do
    params
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {attrs, index}, multi ->
      Multi.insert(
        multi,
        "upsert_project_material_#{index}",
        ProjectMaterial.changeset(
          %ProjectMaterial{},
          Map.merge(attrs, %{project_id: project.id, deleted_at: nil})
        ),
        on_conflict: :replace_all_except_primary_key,
        conflict_target: :id
      )
    end)
  end

  def delete_project_materials(%Project{} = project) do
    Multi.new()
    |> delete_project_materials_query(project)
    |> Repo.transaction()
  end

  defp delete_project_materials_query(multi, %Project{} = project) do
    materials_query = Ecto.assoc(project, :materials)
    Helpers.Multi.soft_delete_all(multi, :delete_project_materials, materials_query)
  end

  def delete_project_material(%ProjectMaterial{} = project_material) do
    Repo.soft_delete(project_material)
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
    Repo.soft_delete(project_file_resource)
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
    Repo.soft_delete(project_method)
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
