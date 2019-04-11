defmodule Birdiy.TimelineTest do
  use Birdiy.DataCase

  alias Birdiy.Timeline

  describe "posts" do
    alias Birdiy.Timeline.Post

    @valid_attrs %{message: "some message", related_project_name: "some related_project_name", related_project_type: "some related_project_type"}
    @update_attrs %{message: "some updated message", related_project_name: "some updated related_project_name", related_project_type: "some updated related_project_type"}
    @invalid_attrs %{message: nil, related_project_name: nil, related_project_type: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeline.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Timeline.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Timeline.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Timeline.create_post(@valid_attrs)
      assert post.message == "some message"
      assert post.related_project_name == "some related_project_name"
      assert post.related_project_type == "some related_project_type"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Timeline.update_post(post, @update_attrs)
      assert post.message == "some updated message"
      assert post.related_project_name == "some updated related_project_name"
      assert post.related_project_type == "some updated related_project_type"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_post(post, @invalid_attrs)
      assert post == Timeline.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Timeline.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Timeline.change_post(post)
    end
  end

  describe "post_photos" do
    alias Birdiy.Timeline.PostPhoto

    @valid_attrs %{image: "some image"}
    @update_attrs %{image: "some updated image"}
    @invalid_attrs %{image: nil}

    def post_photo_fixture(attrs \\ %{}) do
      {:ok, post_photo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeline.create_post_photo()

      post_photo
    end

    test "list_post_photos/0 returns all post_photos" do
      post_photo = post_photo_fixture()
      assert Timeline.list_post_photos() == [post_photo]
    end

    test "get_post_photo!/1 returns the post_photo with given id" do
      post_photo = post_photo_fixture()
      assert Timeline.get_post_photo!(post_photo.id) == post_photo
    end

    test "create_post_photo/1 with valid data creates a post_photo" do
      assert {:ok, %PostPhoto{} = post_photo} = Timeline.create_post_photo(@valid_attrs)
      assert post_photo.image == "some image"
    end

    test "create_post_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_post_photo(@invalid_attrs)
    end

    test "update_post_photo/2 with valid data updates the post_photo" do
      post_photo = post_photo_fixture()
      assert {:ok, %PostPhoto{} = post_photo} = Timeline.update_post_photo(post_photo, @update_attrs)
      assert post_photo.image == "some updated image"
    end

    test "update_post_photo/2 with invalid data returns error changeset" do
      post_photo = post_photo_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_post_photo(post_photo, @invalid_attrs)
      assert post_photo == Timeline.get_post_photo!(post_photo.id)
    end

    test "delete_post_photo/1 deletes the post_photo" do
      post_photo = post_photo_fixture()
      assert {:ok, %PostPhoto{}} = Timeline.delete_post_photo(post_photo)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post_photo!(post_photo.id) end
    end

    test "change_post_photo/1 returns a post_photo changeset" do
      post_photo = post_photo_fixture()
      assert %Ecto.Changeset{} = Timeline.change_post_photo(post_photo)
    end
  end
end
