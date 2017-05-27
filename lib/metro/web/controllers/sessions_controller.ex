defmodule Metro.Web.SessionsController do
  use Metro.Web, :controller

  alias Metro.Accounts
  alias Ueberauth.Strategy.Helpers
  plug Ueberauth

  def new(conn, _params) do
    render conn, "new.html", session_create_url: Helpers.callback_url(conn)
  end

  def create(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.authenticate_user(auth) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Successfully authenticated.")
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  def create(%{assigns: %{ueberauth_failure: _fail}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: "/")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "You shall not pass!")
    |> redirect(to: "/")
  end
end
