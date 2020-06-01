defmodule ReactorWeb.UserLive.New do
  use Phoenix.LiveView
  alias Reactor.Accounts
  alias Accounts.User
  alias ReactorWeb.{UserLive, UserView}
  alias ReactorWeb.Router.Helpers, as: Routes

  def render(assigns), do: UserView.render("new.html", assigns)

  def mount(_params, _session, socket) do
    cset = Accounts.change_user(%User{})
    {:ok, assign(socket, changeset: cset)}
  end

  def handle_event("validate", %{"user" => params}, socket) do
    cset =
      %User{}
      |> Accounts.change_user(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: cset)}
  end

  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        {:stop,
         socket
         # |>put_flash(:info, "User created")
         |> redirect(to: Routes.live_path(socket, UserLive.Show, user))}

      {:error, %Ecto.Changeset{} = cset} ->
        {:noreply, assign(socket, changeset: cset)}
    end
  end
end
