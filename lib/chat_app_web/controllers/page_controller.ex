defmodule ChatAppWeb.PageController do
  use ChatAppWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def name(conn, _params) do
    render(conn, :name, layout: false)
  end
end
