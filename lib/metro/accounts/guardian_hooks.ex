defmodule Metro.GuardianHooks do
  use Guardian.Hooks

  def after_sign_in(conn, location) do
    current_user = Guardian.Plug.current_resource(conn, location)
    Plug.Conn.assign(conn, :current_user, current_user)
  end
end
