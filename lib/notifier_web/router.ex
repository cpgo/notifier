defmodule NotifierWeb.Router do
  use NotifierWeb, :router

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

  scope "/", NotifierWeb do
    pipe_through :browser
    resources "/cards", CardController
    resources "/columns", ColumnController
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", NotifierWeb do
  #   pipe_through :api
  # end
end
