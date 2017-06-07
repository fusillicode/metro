defmodule Metro.Web.SessionsController do
  use Metro.Web, :controller

  alias Metro.Accounts
  alias Ueberauth.Strategy.Helpers
  alias Guardian
  plug Ueberauth

  def new(conn, _params) do
    case Guardian.Plug.authenticated?(conn) do
      true  -> redirect(conn, to: dashboard_path(conn, :index))
      false -> render(conn, "new.html", session_create_url: Helpers.callback_url(conn))
    end
  end

  def create(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.authenticate_user(auth) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Successfully authenticated.")
        |> redirect(to: dashboard_path(conn, :index))
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

  def no_resource(conn, _params), do: unauthenticated(conn, _params)
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "You shall not pass!")
    |> redirect(to: "/")
  end
end
