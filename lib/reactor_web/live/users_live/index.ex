defmodule ReactorWeb.UserLive.Index do
  use Phoenix.LiveView
  alias Reactor.Accounts
  alias ReactorWeb.UserView

  def render(assigns), do: UserView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    if connected?(socket), do: Reactor.Accounts.subscribe()
    {:ok, fetch(socket)}
  end

  defp fetch(socket) do
    users = Accounts.list_users()
    assign(socket, users: users, page_title: "Listing Users")
  end

  def handle_event("delete_user", %{"id" => user_id}, socket) do
    Accounts.get_user!(user_id)
    |> Accounts.delete_user()

    {:noreply, socket}
  end

  def handle_info({Accounts, [:user, _], _}, socket) do
    {:noreply, fetch(socket)}
  end
end
