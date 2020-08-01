defmodule ReactorWeb.PodcastController do
  use ReactorWeb, :controller

  alias Reactor.Content
  alias Reactor.Content.Podcast

  def index(conn, _params) do
    podcasts = Content.list_podcasts()
    render(conn, "index.html", podcasts: podcasts)
  end

  def new(conn, _params) do
    changeset = Content.change_podcast(%Podcast{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"podcast" => podcast_params}) do
    case Content.create_podcast(podcast_params) do
      {:ok, podcast} ->
        conn
        |> put_flash(:info, "Podcast created successfully.")
        |> redirect(to: Routes.podcast_path(conn, :show, podcast))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    podcast = Content.get_podcast!(id)
    changeset = Content.change_comment(%Content.Comment{})
    render(conn, "show.html", podcast: podcast, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    podcast = Content.get_podcast!(id)
    changeset = Content.change_podcast(podcast)
    render(conn, "edit.html", podcast: podcast, changeset: changeset)
  end

  def update(conn, %{"id" => id, "podcast" => podcast_params}) do
    podcast = Content.get_podcast!(id)

    case Content.update_podcast(podcast, podcast_params) do
      {:ok, podcast} ->
        conn
        |> put_flash(:info, "Podcast updated successfully.")
        |> redirect(to: Routes.podcast_path(conn, :show, podcast))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", podcast: podcast, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    podcast = Content.get_podcast!(id)
    {:ok, _podcast} = Content.delete_podcast(podcast)

    conn
    |> put_flash(:info, "Podcast deleted successfully.")
    |> redirect(to: Routes.podcast_path(conn, :index))
  end
end
