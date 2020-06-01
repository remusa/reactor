defmodule ReactorWeb.FooLive do
  use Phoenix.LiveView
  alias ReactorWeb.PageView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, msg: "none")}
  end

  def render(assigns), do: PageView.render("foo.html", assigns)

  def handle_event("foo_key", %{"key" => key} = stuff, socket) do
    IO.inspect(stuff)
    {:noreply, assign(socket, msg: key)}
  end

  def handle_event(event, stuff, socket) do
    IO.puts("Event: #{event}")
    IO.inspect(stuff)
    {:noreply, socket}
  end
end
