defmodule Birdiy.DiyTest do
  use Birdiy.DataCase

  alias Birdiy.Diy

  describe "project_categories" do
    alias Birdiy.Diy.ProjectCategory

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def project_category_fixture(attrs \\ %{}) do
      {:ok, project_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Diy.create_project_category()

      project_category
    end

    test "list_project_categories/0 returns all project_categories" do
      project_category = project_category_fixture()
      assert Diy.list_project_categories() == [project_category]
    end

    test "get_project_category!/1 returns the project_category with given id" do
      project_category = project_category_fixture()
      assert Diy.get_project_category!(project_category.id) == project_category
    end

    test "create_project_category/1 with valid data creates a project_category" do
      assert {:ok, %ProjectCategory{} = project_category} = Diy.create_project_category(@valid_attrs)
      assert project_category.name == "some name"
    end

    test "create_project_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diy.create_project_category(@invalid_attrs)
    end

    test "update_project_category/2 with valid data updates the project_category" do
      project_category = project_category_fixture()
      assert {:ok, %ProjectCategory{} = project_category} = Diy.update_project_category(project_category, @update_attrs)
      assert project_category.name == "some updated name"
    end

    test "update_project_category/2 with invalid data returns error changeset" do
      project_category = project_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Diy.update_project_category(project_category, @invalid_attrs)
      assert project_category == Diy.get_project_category!(project_category.id)
    end

    test "delete_project_category/1 deletes the project_category" do
      project_category = project_category_fixture()
      assert {:ok, %ProjectCategory{}} = Diy.delete_project_category(project_category)
      assert_raise Ecto.NoResultsError, fn -> Diy.get_project_category!(project_category.id) end
    end

    test "change_project_category/1 returns a project_category changeset" do
      project_category = project_category_fixture()
      assert %Ecto.Changeset{} = Diy.change_project_category(project_category)
    end
  end

  describe "projects" do
    alias Birdiy.Diy.Project

    @valid_attrs %{introduction: "some introduction", name: "some name", tip: "some tip"}
    @update_attrs %{introduction: "some updated introduction", name: "some updated name", tip: "some updated tip"}
    @invalid_attrs %{introduction: nil, name: nil, tip: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Diy.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Diy.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Diy.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Diy.create_project(@valid_attrs)
      assert project.introduction == "some introduction"
      assert project.name == "some name"
      assert project.tip == "some tip"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diy.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Diy.update_project(project, @update_attrs)
      assert project.introduction == "some updated introduction"
      assert project.name == "some updated name"
      assert project.tip == "some updated tip"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Diy.update_project(project, @invalid_attrs)
      assert project == Diy.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Diy.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Diy.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Diy.change_project(project)
    end
  end
end
