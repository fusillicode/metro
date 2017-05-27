defmodule Metro.Web.Router do
  use Metro.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated,
      handler: Metro.Web.SessionsController
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Metro.Web do
    pipe_through :browser

    get    "/",       SessionsController, :new
    post   "/",       SessionsController, :create
    delete "/logout", SessionsController, :delete
  end

  scope "/admin", Metro.Web do
    pipe_through :browser
    pipe_through :browser_auth

    get "/", Admin.DashboardController, :new
  end
end
