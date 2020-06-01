defmodule ReactorWeb.UserLive.Edit do
  use Phoenix.LiveView
  alias Phoenix.LiveView.Socket
  alias Reactor.Accounts
  alias Accounts.User
  alias ReactorWeb.{UserLive, UserView}
  alias ReactorWeb.Router.Helpers, as: Routes
  alias Phoenix.LiveView.Socket

  def render(assigns), do: UserView.render("edit.html", assigns)
  def mount(_session, socket), do: {:ok, socket}

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: Accounts.subscribe(id)
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    user = Accounts.get_user!(id)
    assign(socket, user: user, changeset: Accounts.change_user(user))
  end

  def handle_event("validate", %{"user" => params}, socket) do
    cset =
      socket.assigns.user
      |> Accounts.change_user(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: cset)}
  end

  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.update_user(socket.assigns.user, params) do
      {:ok, user} ->
        {:stop,
         socket
         #  |> put_flash(:info, "user updated")
         |> redirect(to: Routes.live_path(socket, UserLive.Show, user))}

      {:error, %Ecto.Changeset{} = cset} ->
        {:noreply, assign(socket, changeset: cset)}
    end
  end

  def handle_info({Accounts, [:user, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Accounts, [:user, :deleted], _}, socket) do
    {:stop,
     socket
     # |> put_flash(:error, "This user has been deleted.")
     |> redirect(to: Routes.live_path(socket, UserLive.Index))}
  end
end
