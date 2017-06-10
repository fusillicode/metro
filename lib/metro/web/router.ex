defmodule Metro.Web.Router do
  use Metro.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :browser_auth do
    plug Guardian.Plug.EnsureResource,
      handler: Metro.Web.SessionsController
    plug Guardian.Plug.EnsureAuthenticated,
      handler: Metro.Web.SessionsController
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Metro.Web do
    pipe_through [:browser]

    get    "/",       SessionsController, :new
    post   "/",       SessionsController, :create
    delete "/logout", SessionsController, :delete
  end

  scope "/admin", Metro.Web, as: :admin do
    pipe_through [:browser, :browser_auth]

    get "/", Admin.DashboardController, :index

    resources "/media", Admin.MediaController
  end
end
