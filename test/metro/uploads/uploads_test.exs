defmodule Metro.UploadsTest do
  use Metro.DataCase

  alias Metro.Uploads

  describe "media" do
    alias Metro.Uploads.Media

    @valid_attrs %{name: "some name", path: "some path"}
    @update_attrs %{name: "some updated name", path: "some updated path"}
    @invalid_attrs %{name: nil, path: nil}

    def media_fixture(attrs \\ %{}) do
      {:ok, media} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Uploads.create_media()

      media
    end

    test "list_media/0 returns all media" do
      media = media_fixture()
      assert Uploads.list_media() == [media]
    end

    test "get_media!/1 returns the media with given id" do
      media = media_fixture()
      assert Uploads.get_media!(media.id) == media
    end

    test "create_media/1 with valid data creates a media" do
      assert {:ok, %Media{} = media} = Uploads.create_media(@valid_attrs)
      assert media.name == "some name"
      assert media.path == "some path"
    end

    test "create_media/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Uploads.create_media(@invalid_attrs)
    end

    test "update_media/2 with valid data updates the media" do
      media = media_fixture()
      assert {:ok, media} = Uploads.update_media(media, @update_attrs)
      assert %Media{} = media
      assert media.name == "some updated name"
      assert media.path == "some updated path"
    end

    test "update_media/2 with invalid data returns error changeset" do
      media = media_fixture()
      assert {:error, %Ecto.Changeset{}} = Uploads.update_media(media, @invalid_attrs)
      assert media == Uploads.get_media!(media.id)
    end

    test "delete_media/1 deletes the media" do
      media = media_fixture()
      assert {:ok, %Media{}} = Uploads.delete_media(media)
      assert_raise Ecto.NoResultsError, fn -> Uploads.get_media!(media.id) end
    end

    test "change_media/1 returns a media changeset" do
      media = media_fixture()
      assert %Ecto.Changeset{} = Uploads.change_media(media)
    end
  end
end
