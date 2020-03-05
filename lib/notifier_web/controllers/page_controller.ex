defmodule NotifierWeb.PageController do
  use NotifierWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
