defmodule Birdiy.DiyTest do
  use Birdiy.DataCase

  alias Birdiy.Diy

  describe "project_comments" do
    alias Birdiy.Diy.ProjectComment

    @valid_attrs %{message: "some message"}
    @update_attrs %{message: "some updated message"}
    @invalid_attrs %{message: nil}

    def project_comment_fixture(attrs \\ %{}) do
      {:ok, project_comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Diy.create_project_comment()

      project_comment
    end

    test "list_project_comments/0 returns all project_comments" do
      project_comment = project_comment_fixture()
      assert Diy.list_project_comments() == [project_comment]
    end

    test "get_project_comment!/1 returns the project_comment with given id" do
      project_comment = project_comment_fixture()
      assert Diy.get_project_comment!(project_comment.id) == project_comment
    end

    test "create_project_comment/1 with valid data creates a project_comment" do
      assert {:ok, %ProjectComment{} = project_comment} = Diy.create_project_comment(@valid_attrs)
      assert project_comment.message == "some message"
    end

    test "create_project_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diy.create_project_comment(@invalid_attrs)
    end

    test "update_project_comment/2 with valid data updates the project_comment" do
      project_comment = project_comment_fixture()

      assert {:ok, %ProjectComment{} = project_comment} =
               Diy.update_project_comment(project_comment, @update_attrs)

      assert project_comment.message == "some updated message"
    end

    test "update_project_comment/2 with invalid data returns error changeset" do
      project_comment = project_comment_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Diy.update_project_comment(project_comment, @invalid_attrs)

      assert project_comment == Diy.get_project_comment!(project_comment.id)
    end

    test "delete_project_comment/1 deletes the project_comment" do
      project_comment = project_comment_fixture()
      assert {:ok, %ProjectComment{}} = Diy.delete_project_comment(project_comment)
      assert_raise Ecto.NoResultsError, fn -> Diy.get_project_comment!(project_comment.id) end
    end

    test "change_project_comment/1 returns a project_comment changeset" do
      project_comment = project_comment_fixture()
      assert %Ecto.Changeset{} = Diy.change_project_comment(project_comment)
    end
  end
end
