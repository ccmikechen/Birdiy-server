defmodule Birdiy.AccountsTest do
  use Birdiy.DataCase

  alias Birdiy.Accounts

  describe "users" do
    alias Birdiy.Accounts.User

    @valid_attrs %{image: "some image", name: "some name"}
    @update_attrs %{image: "some updated image", name: "some updated name"}
    @invalid_attrs %{image: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.image == "some image"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.image == "some updated image"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "user_followings" do
    alias Birdiy.Accounts.UserFollowing

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_following_fixture(attrs \\ %{}) do
      {:ok, user_following} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_following()

      user_following
    end

    test "list_user_followings/0 returns all user_followings" do
      user_following = user_following_fixture()
      assert Accounts.list_user_followings() == [user_following]
    end

    test "get_user_following!/1 returns the user_following with given id" do
      user_following = user_following_fixture()
      assert Accounts.get_user_following!(user_following.id) == user_following
    end

    test "create_user_following/1 with valid data creates a user_following" do
      assert {:ok, %UserFollowing{} = user_following} = Accounts.create_user_following(@valid_attrs)
    end

    test "create_user_following/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_following(@invalid_attrs)
    end

    test "update_user_following/2 with valid data updates the user_following" do
      user_following = user_following_fixture()
      assert {:ok, %UserFollowing{} = user_following} = Accounts.update_user_following(user_following, @update_attrs)
    end

    test "update_user_following/2 with invalid data returns error changeset" do
      user_following = user_following_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_following(user_following, @invalid_attrs)
      assert user_following == Accounts.get_user_following!(user_following.id)
    end

    test "delete_user_following/1 deletes the user_following" do
      user_following = user_following_fixture()
      assert {:ok, %UserFollowing{}} = Accounts.delete_user_following(user_following)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_following!(user_following.id) end
    end

    test "change_user_following/1 returns a user_following changeset" do
      user_following = user_following_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_following(user_following)
    end
  end

  describe "user_favorite_projects" do
    alias Birdiy.Accounts.UserFavoriteProject

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_favorite_project_fixture(attrs \\ %{}) do
      {:ok, user_favorite_project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_favorite_project()

      user_favorite_project
    end

    test "list_user_favorite_projects/0 returns all user_favorite_projects" do
      user_favorite_project = user_favorite_project_fixture()
      assert Accounts.list_user_favorite_projects() == [user_favorite_project]
    end

    test "get_user_favorite_project!/1 returns the user_favorite_project with given id" do
      user_favorite_project = user_favorite_project_fixture()
      assert Accounts.get_user_favorite_project!(user_favorite_project.id) == user_favorite_project
    end

    test "create_user_favorite_project/1 with valid data creates a user_favorite_project" do
      assert {:ok, %UserFavoriteProject{} = user_favorite_project} = Accounts.create_user_favorite_project(@valid_attrs)
    end

    test "create_user_favorite_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_favorite_project(@invalid_attrs)
    end

    test "update_user_favorite_project/2 with valid data updates the user_favorite_project" do
      user_favorite_project = user_favorite_project_fixture()
      assert {:ok, %UserFavoriteProject{} = user_favorite_project} = Accounts.update_user_favorite_project(user_favorite_project, @update_attrs)
    end

    test "update_user_favorite_project/2 with invalid data returns error changeset" do
      user_favorite_project = user_favorite_project_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_favorite_project(user_favorite_project, @invalid_attrs)
      assert user_favorite_project == Accounts.get_user_favorite_project!(user_favorite_project.id)
    end

    test "delete_user_favorite_project/1 deletes the user_favorite_project" do
      user_favorite_project = user_favorite_project_fixture()
      assert {:ok, %UserFavoriteProject{}} = Accounts.delete_user_favorite_project(user_favorite_project)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_favorite_project!(user_favorite_project.id) end
    end

    test "change_user_favorite_project/1 returns a user_favorite_project changeset" do
      user_favorite_project = user_favorite_project_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_favorite_project(user_favorite_project)
    end
  end

  describe "user_liked_projects" do
    alias Birdiy.Accounts.UserLikedProject

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_liked_project_fixture(attrs \\ %{}) do
      {:ok, user_liked_project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_liked_project()

      user_liked_project
    end

    test "list_user_liked_projects/0 returns all user_liked_projects" do
      user_liked_project = user_liked_project_fixture()
      assert Accounts.list_user_liked_projects() == [user_liked_project]
    end

    test "get_user_liked_project!/1 returns the user_liked_project with given id" do
      user_liked_project = user_liked_project_fixture()
      assert Accounts.get_user_liked_project!(user_liked_project.id) == user_liked_project
    end

    test "create_user_liked_project/1 with valid data creates a user_liked_project" do
      assert {:ok, %UserLikedProject{} = user_liked_project} = Accounts.create_user_liked_project(@valid_attrs)
    end

    test "create_user_liked_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_liked_project(@invalid_attrs)
    end

    test "update_user_liked_project/2 with valid data updates the user_liked_project" do
      user_liked_project = user_liked_project_fixture()
      assert {:ok, %UserLikedProject{} = user_liked_project} = Accounts.update_user_liked_project(user_liked_project, @update_attrs)
    end

    test "update_user_liked_project/2 with invalid data returns error changeset" do
      user_liked_project = user_liked_project_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_liked_project(user_liked_project, @invalid_attrs)
      assert user_liked_project == Accounts.get_user_liked_project!(user_liked_project.id)
    end

    test "delete_user_liked_project/1 deletes the user_liked_project" do
      user_liked_project = user_liked_project_fixture()
      assert {:ok, %UserLikedProject{}} = Accounts.delete_user_liked_project(user_liked_project)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_liked_project!(user_liked_project.id) end
    end

    test "change_user_liked_project/1 returns a user_liked_project changeset" do
      user_liked_project = user_liked_project_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_liked_project(user_liked_project)
    end
  end

  describe "user_viewed_projects" do
    alias Birdiy.Accounts.UserViewedProject

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_viewed_project_fixture(attrs \\ %{}) do
      {:ok, user_viewed_project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_viewed_project()

      user_viewed_project
    end

    test "list_user_viewed_projects/0 returns all user_viewed_projects" do
      user_viewed_project = user_viewed_project_fixture()
      assert Accounts.list_user_viewed_projects() == [user_viewed_project]
    end

    test "get_user_viewed_project!/1 returns the user_viewed_project with given id" do
      user_viewed_project = user_viewed_project_fixture()
      assert Accounts.get_user_viewed_project!(user_viewed_project.id) == user_viewed_project
    end

    test "create_user_viewed_project/1 with valid data creates a user_viewed_project" do
      assert {:ok, %UserViewedProject{} = user_viewed_project} = Accounts.create_user_viewed_project(@valid_attrs)
    end

    test "create_user_viewed_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_viewed_project(@invalid_attrs)
    end

    test "update_user_viewed_project/2 with valid data updates the user_viewed_project" do
      user_viewed_project = user_viewed_project_fixture()
      assert {:ok, %UserViewedProject{} = user_viewed_project} = Accounts.update_user_viewed_project(user_viewed_project, @update_attrs)
    end

    test "update_user_viewed_project/2 with invalid data returns error changeset" do
      user_viewed_project = user_viewed_project_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_viewed_project(user_viewed_project, @invalid_attrs)
      assert user_viewed_project == Accounts.get_user_viewed_project!(user_viewed_project.id)
    end

    test "delete_user_viewed_project/1 deletes the user_viewed_project" do
      user_viewed_project = user_viewed_project_fixture()
      assert {:ok, %UserViewedProject{}} = Accounts.delete_user_viewed_project(user_viewed_project)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_viewed_project!(user_viewed_project.id) end
    end

    test "change_user_viewed_project/1 returns a user_viewed_project changeset" do
      user_viewed_project = user_viewed_project_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_viewed_project(user_viewed_project)
    end
  end
end
