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
end
