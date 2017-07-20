defmodule Metro.Web.Admin.DashboardController do
  use Metro.Web, :controller
  use Drab.Controller

  def index(conn, _params) do
    render conn, "index.html", text: 'hi there!'
  end
end
