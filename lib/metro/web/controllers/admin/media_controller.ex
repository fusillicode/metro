defmodule Metro.Web.Admin.MediaController do
  use Metro.Web, :controller

  alias Metro.Uploads

  def index(conn, _params) do
    media = Uploads.list_media()
    render(conn, "index.html", media: media)
  end

  def new(conn, _params) do
    changeset = Uploads.change_media(%Metro.Uploads.Media{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"media" => media_params}) do
    case Uploads.create_media(media_params) do
      {:ok, media} ->
        conn
        |> put_flash(:info, "Media created successfully.")
        |> redirect(to: admin_media_path(conn, :show, media))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    media = Uploads.get_media!(id)
    render(conn, "show.html", media: media)
  end

  def edit(conn, %{"id" => id}) do
    media = Uploads.get_media!(id)
    changeset = Uploads.change_media(media)
    render(conn, "edit.html", media: media, changeset: changeset)
  end

  def update(conn, %{"id" => id, "media" => media_params}) do
    media = Uploads.get_media!(id)

    case Uploads.update_media(media, media_params) do
      {:ok, media} ->
        conn
        |> put_flash(:info, "Media updated successfully.")
        |> redirect(to: admin_media_path(conn, :show, media))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", media: media, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    media = Uploads.get_media!(id)
    {:ok, _media} = Uploads.delete_media(media)

    conn
    |> put_flash(:info, "Media deleted successfully.")
    |> redirect(to: admin_media_path(conn, :index))
  end
end
