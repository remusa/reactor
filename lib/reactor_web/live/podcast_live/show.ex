defmodule ReactorWeb.PodcastLive.Show do
  use Phoenix.LiveView, layout: {ReactorWeb.LayoutView, "live.html"}
  alias Reactor.{Accounts, Content}
  alias Content.Comment
  alias ReactorWeb.{PodcastView}
  alias ReactorWeb.Router.Helpers, as: Routes
  alias Phoenix.LiveView.Socket

  @comment inspect(Comment)

  def render(assigns), do: PodcastView.render("show.html", assigns)

  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)
    admin_user = ReactorWeb.Auth.is_admin?(current_user)

    {:ok,
      socket
      |> assign(current_user: current_user, admin_user: admin_user)
    }
  end

  def mount(_params, _session, socket) do
    {:ok,socket> assign(current_user: nil, admin_user: nil)}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket) do
      Content.subscribe_one(id)
      Content.subscribe(@comment)
    end

    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  def fetch(%Socket{assigns: %{id => id}} = socket) do
    podcst = Content.get_podcast!(id)
    changeset = Content.change_comment(%Content.Comment{})}

    if connected?(socket) do
      podcast.comments
      |> Enum.each(&Content.subscribe_one(&1.id, @comment))
    end

    assign(socket, podcast: podcast, changeset: changeset)
  end

  def handle_info({Content, [:podcast, :updated]}, _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Content, [:podcast, :deleted]}, _}, socket) do
    {:noreply,
      socket
      |> redirect(to: Routes.podcast_path(socket, :index))
    }
  end

  def handle_info({Content, [:podcast, :created]}, _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Content, [:podcast, :updated]}, _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Content, [:podcast, :deleted]}, _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("save", %{"comment" => params}, socket) do
    {:noreply, socket}

    case Content.create_comment(params) do
      {:ok, _comment} ->
        {:noreply,
          socket
          |> put_flash(:info, "Comment created")
        }

        {:error, %Ecto.Changeset{} = cset} ->
          {:noreply, assign(socket, changeset: cset)}
    end
  end

  def handle_event("validate", %{"comment" => params}, socket) do
    cset =
      %Content.Comment{}
      |> Content.change_comment(params)
      |> Map.puth(:action, :insert)

      {:noreply, assign(socket, changeset: cset)}
  end
end
