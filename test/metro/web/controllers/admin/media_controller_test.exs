defmodule Metro.Web.Admin.MediaControllerTest do
  use Metro.Web.ConnCase

  alias Metro.{Uploads, Accounts}

  @create_attrs %{name: "some name", path: "some path"}
  @update_attrs %{name: "some updated name", path: "some updated path"}
  @invalid_attrs %{name: nil, path: nil}

  def fixture(:media) do
    {:ok, media} = Uploads.create_media(@create_attrs)
    media
  end

  test "lists all entries on index", %{conn: conn} do
    {:ok, user} = Accounts.register_user(%{email: "joe@test.com", password: "password"})
    conn = login(conn, user)
    conn = get(conn, admin_media_path(conn, :index))
    assert html_response(conn, 200) =~ "Listing Media"
  end

  test "renders form for new media", %{conn: conn} do
    conn = get conn, admin_media_path(conn, :new)
    assert html_response(conn, 200) =~ "New Media"
  end

  test "creates media and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, admin_media_path(conn, :create), media: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == admin_media_path(conn, :show, id)

    conn = get conn, admin_media_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Media"
  end

  test "does not create media and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_media_path(conn, :create), media: @invalid_attrs
    assert html_response(conn, 200) =~ "New Media"
  end

  test "renders form for editing chosen media", %{conn: conn} do
    media = fixture(:media)
    conn = get conn, admin_media_path(conn, :edit, media)
    assert html_response(conn, 200) =~ "Edit Media"
  end

  test "updates chosen media and redirects when data is valid", %{conn: conn} do
    media = fixture(:media)
    conn = put conn, admin_media_path(conn, :update, media), media: @update_attrs
    assert redirected_to(conn) == admin_media_path(conn, :show, media)

    conn = get conn, admin_media_path(conn, :show, media)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen media and renders errors when data is invalid", %{conn: conn} do
    media = fixture(:media)
    conn = put conn, admin_media_path(conn, :update, media), media: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Media"
  end

  test "deletes chosen media", %{conn: conn} do
    media = fixture(:media)
    conn = delete conn, admin_media_path(conn, :delete, media)
    assert redirected_to(conn) == admin_media_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, admin_media_path(conn, :show, media)
    end
  end
end
