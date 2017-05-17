defmodule Metro.Web.PageController do
  use Metro.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
