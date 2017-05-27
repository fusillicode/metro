defmodule Metro.Web.Admin.DashboardController do
  use Metro.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end
end
