defmodule ReactorWeb.CommentController do
  use ReactorWeb, :controller

  alias Reactor.Content
  alias Reactor.Content.Comment

  plug(:authenticate_admin when not
        (action in [:create, :show, :edit, :update, :delete))

  plug(:logged_in_user when not (action in [:show]))
  plug(:correct_user when not (action in [:edit, :update, :delete))

  @default_route Routes.comment_path(ReactorWeb.Endpoint, :index)

  def index(conn, _params) do
    comments = Content.list_comments()
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = Content.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Content.create_comment(comment_params) do
      {:ok, comment} ->
        url =
          case params["redirect_url"] do
            "#comment-new" ->
              Routes.podcast_path(conn, :show, comment.podcast_id) <> "#comment-#{comment.id}"
            nil ->
              Routes.comment_path(conn, :show, comment)
            x ->
              x
          end

        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: url)

      {:error, %Ecto.Changeset{} = %{errors: [content: {msg, _}]}} ->
        url =
          case params["redirect_url"] do
            "#comment-new" -> Routes.comment_path(conn, :index)
            x -> x
          end

        conn
        |> put_flash(:error, "Invalid comment: #{msg}")
        |> redirect(to: url)
        |> halt()
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Content.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Content.get_comment!(id)
    changeset = Content.change_comment(comment)

    render(conn, "edit.html", comment: comment, changeset: changeset, redirect_url: redirect_url(params))
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Content.get_comment!(id)

    case Content.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(
            to: Routes.comment_path(conn, :show, comment, redirect_url: redirect_url(params))
          )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Content.get_comment!(id)
    {:ok, _comment} = Content.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end

  defp redirect_url(params, default \\ @default_route) do
    case params["redirect_url"] do
      nil -> default
      redirect -> redirect
    end
  end

  defp to_redirect_or(conn, default) do
    redirect(conn, to: redirect_url(conn.params, default))
  end
end
