defmodule Metro.Web.SessionsController do
  use Metro.Web, :controller

  alias Ueberauth.Strategy.Helpers
  plug Ueberauth

  def new(conn, _params) do
    render conn, "new.html", session_create_url: Helpers.callback_url(conn)
  end

  def create(%{assigns: %{ueberauth_auth: _auth}} = conn, _params) do
  end

  def delete() do
  end
end
