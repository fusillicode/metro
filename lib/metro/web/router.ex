defmodule Metro.Web.Router do
  use Metro.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Metro.Web do
    pipe_through :browser # Use the default browser stack

    get     "/",      SessionsController, :new
    post    "/",      SessionsController, :create
    delete "/logout", SessionsController, :delete
  end
end
