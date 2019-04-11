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
      assert {:ok, %ProjectCategory{} = project_category} =
               Diy.create_project_category(@valid_attrs)

      assert project_category.name == "some name"
    end

    test "create_project_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diy.create_project_category(@invalid_attrs)
    end

    test "update_project_category/2 with valid data updates the project_category" do
      project_category = project_category_fixture()

      assert {:ok, %ProjectCategory{} = project_category} =
               Diy.update_project_category(project_category, @update_attrs)

      assert project_category.name == "some updated name"
    end

    test "update_project_category/2 with invalid data returns error changeset" do
      project_category = project_category_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Diy.update_project_category(project_category, @invalid_attrs)

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
    @update_attrs %{
      introduction: "some updated introduction",
      name: "some updated name",
      tip: "some updated tip"
    }
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

  describe "project_materials" do
    alias Birdiy.Diy.ProjectMaterial

    @valid_attrs %{amountUnit: "some amountUnit", name: "some name", url: "some url"}
    @update_attrs %{
      amountUnit: "some updated amountUnit",
      name: "some updated name",
      url: "some updated url"
    }
    @invalid_attrs %{amountUnit: nil, name: nil, url: nil}

    def project_material_fixture(attrs \\ %{}) do
      {:ok, project_material} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Diy.create_project_material()

      project_material
    end

    test "list_project_materials/0 returns all project_materials" do
      project_material = project_material_fixture()
      assert Diy.list_project_materials() == [project_material]
    end

    test "get_project_material!/1 returns the project_material with given id" do
      project_material = project_material_fixture()
      assert Diy.get_project_material!(project_material.id) == project_material
    end

    test "create_project_material/1 with valid data creates a project_material" do
      assert {:ok, %ProjectMaterial{} = project_material} =
               Diy.create_project_material(@valid_attrs)

      assert project_material.amountUnit == "some amountUnit"
      assert project_material.name == "some name"
      assert project_material.url == "some url"
    end

    test "create_project_material/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diy.create_project_material(@invalid_attrs)
    end

    test "update_project_material/2 with valid data updates the project_material" do
      project_material = project_material_fixture()

      assert {:ok, %ProjectMaterial{} = project_material} =
               Diy.update_project_material(project_material, @update_attrs)

      assert project_material.amountUnit == "some updated amountUnit"
      assert project_material.name == "some updated name"
      assert project_material.url == "some updated url"
    end

    test "update_project_material/2 with invalid data returns error changeset" do
      project_material = project_material_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Diy.update_project_material(project_material, @invalid_attrs)

      assert project_material == Diy.get_project_material!(project_material.id)
    end

    test "delete_project_material/1 deletes the project_material" do
      project_material = project_material_fixture()
      assert {:ok, %ProjectMaterial{}} = Diy.delete_project_material(project_material)
      assert_raise Ecto.NoResultsError, fn -> Diy.get_project_material!(project_material.id) end
    end

    test "change_project_material/1 returns a project_material changeset" do
      project_material = project_material_fixture()
      assert %Ecto.Changeset{} = Diy.change_project_material(project_material)
    end
  end

  describe "project_file_resources" do
    alias Birdiy.Diy.ProjectFileResource

    @valid_attrs %{name: "some name", url: "some url"}
    @update_attrs %{name: "some updated name", url: "some updated url"}
    @invalid_attrs %{name: nil, url: nil}

    def project_file_resource_fixture(attrs \\ %{}) do
      {:ok, project_file_resource} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Diy.create_project_file_resource()

      project_file_resource
    end

    test "list_project_file_resources/0 returns all project_file_resources" do
      project_file_resource = project_file_resource_fixture()
      assert Diy.list_project_file_resources() == [project_file_resource]
    end

    test "get_project_file_resource!/1 returns the project_file_resource with given id" do
      project_file_resource = project_file_resource_fixture()
      assert Diy.get_project_file_resource!(project_file_resource.id) == project_file_resource
    end

    test "create_project_file_resource/1 with valid data creates a project_file_resource" do
      assert {:ok, %ProjectFileResource{} = project_file_resource} =
               Diy.create_project_file_resource(@valid_attrs)

      assert project_file_resource.name == "some name"
      assert project_file_resource.url == "some url"
    end

    test "create_project_file_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diy.create_project_file_resource(@invalid_attrs)
    end

    test "update_project_file_resource/2 with valid data updates the project_file_resource" do
      project_file_resource = project_file_resource_fixture()

      assert {:ok, %ProjectFileResource{} = project_file_resource} =
               Diy.update_project_file_resource(project_file_resource, @update_attrs)

      assert project_file_resource.name == "some updated name"
      assert project_file_resource.url == "some updated url"
    end

    test "update_project_file_resource/2 with invalid data returns error changeset" do
      project_file_resource = project_file_resource_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Diy.update_project_file_resource(project_file_resource, @invalid_attrs)

      assert project_file_resource == Diy.get_project_file_resource!(project_file_resource.id)
    end

    test "delete_project_file_resource/1 deletes the project_file_resource" do
      project_file_resource = project_file_resource_fixture()

      assert {:ok, %ProjectFileResource{}} =
               Diy.delete_project_file_resource(project_file_resource)

      assert_raise Ecto.NoResultsError, fn ->
        Diy.get_project_file_resource!(project_file_resource.id)
      end
    end

    test "change_project_file_resource/1 returns a project_file_resource changeset" do
      project_file_resource = project_file_resource_fixture()
      assert %Ecto.Changeset{} = Diy.change_project_file_resource(project_file_resource)
    end
  end

  describe "project_methods" do
    alias Birdiy.Diy.ProjectMethod

    @valid_attrs %{
      content: "some content",
      image: "some image",
      order: "120.5",
      title: "some title"
    }
    @update_attrs %{
      content: "some updated content",
      image: "some updated image",
      order: "456.7",
      title: "some updated title"
    }
    @invalid_attrs %{content: nil, image: nil, order: nil, title: nil}

    def project_method_fixture(attrs \\ %{}) do
      {:ok, project_method} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Diy.create_project_method()

      project_method
    end

    test "list_project_methods/0 returns all project_methods" do
      project_method = project_method_fixture()
      assert Diy.list_project_methods() == [project_method]
    end

    test "get_project_method!/1 returns the project_method with given id" do
      project_method = project_method_fixture()
      assert Diy.get_project_method!(project_method.id) == project_method
    end

    test "create_project_method/1 with valid data creates a project_method" do
      assert {:ok, %ProjectMethod{} = project_method} = Diy.create_project_method(@valid_attrs)
      assert project_method.content == "some content"
      assert project_method.image == "some image"
      assert project_method.order == Decimal.new("120.5")
      assert project_method.title == "some title"
    end

    test "create_project_method/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diy.create_project_method(@invalid_attrs)
    end

    test "update_project_method/2 with valid data updates the project_method" do
      project_method = project_method_fixture()

      assert {:ok, %ProjectMethod{} = project_method} =
               Diy.update_project_method(project_method, @update_attrs)

      assert project_method.content == "some updated content"
      assert project_method.image == "some updated image"
      assert project_method.order == Decimal.new("456.7")
      assert project_method.title == "some updated title"
    end

    test "update_project_method/2 with invalid data returns error changeset" do
      project_method = project_method_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Diy.update_project_method(project_method, @invalid_attrs)

      assert project_method == Diy.get_project_method!(project_method.id)
    end

    test "delete_project_method/1 deletes the project_method" do
      project_method = project_method_fixture()
      assert {:ok, %ProjectMethod{}} = Diy.delete_project_method(project_method)
      assert_raise Ecto.NoResultsError, fn -> Diy.get_project_method!(project_method.id) end
    end

    test "change_project_method/1 returns a project_method changeset" do
      project_method = project_method_fixture()
      assert %Ecto.Changeset{} = Diy.change_project_method(project_method)
    end
  end
end
