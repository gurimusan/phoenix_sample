defmodule PhoenixSample.Router do
  use PhoenixSample.Web, :router

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

  pipeline :authenticated do
    plug PhoenixSample.AuthAccessPipline
  end

  scope "/api", PhoenixSample do
    pipe_through :api
    post "/signin", SecurityController, :signin

    pipe_through :authenticated
    get "/users", UserController, :index
    post "/users", UserController, :create
    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixSample do
  #   pipe_through :api
  # end
end
