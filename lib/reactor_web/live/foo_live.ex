defmodule ReactorWeb.FooLive do
  use Phoenix.LiveView
  alias ReactorWeb.PageView

  def mount(_session, socket) do
    {:ok, assign(socket, msg: "none")}
  end

  def render(assigns), do: PageView.render("foo.html", assigns)

  def handle_event("keydown", %{"key" => key}, socket) do
    {:noreply, assign(socket, msg: key )}
  end
end
