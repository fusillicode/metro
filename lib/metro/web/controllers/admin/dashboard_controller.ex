defmodule Metro.Web.Admin.DashboardController do
  use Metro.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
