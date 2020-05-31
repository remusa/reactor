defmodule ReactorWeb.PageController do
  use ReactorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
