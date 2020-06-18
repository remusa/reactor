defmodule ReactorWeb.SessionController do
  use ReactorWeb, :controller

  alias ReactorWeb.Accounts

  # Uncommment these after configuring an emailer
  # alias Reactor.Accounts.Email
  # alias Reactor.Mailer

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => "", "password" => ""}}) do
    conn
    |> put_flash(:error, "Please fill in an email and a password")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_by_email_password(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: Routes.page_path(conn, :new))

      {:error, :unauthorized} ->
        conn
        |> put_flash(:info, "Incorrect email/password combination")
        |> redirect(to: Routes.session_path(conn, :new))

      {:error, :not_found} ->
        conn
        |> put_flash(:info, "Account not found")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def create_from_token(conn, %{"email" => email, "token" => token}) do
    case Accounts.authenticate_by_email_token(email, token) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: Routes.live_path(conn, ReactorWeb.UserLive.Show, user))

      _ ->
        conn
        |> put_flash(:error, "Invalid login")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end
end
