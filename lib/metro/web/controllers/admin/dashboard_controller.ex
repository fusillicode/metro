defmodule Metro.Web.Admin.DashboardController do
  use Metro.Web, :controller

  alias Metro.Accounts

  def new(conn, _params) do
    render conn, "new.html"
  end
end
