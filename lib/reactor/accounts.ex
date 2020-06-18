defmodule Reactor.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Reactor.Repo

  alias Reactor.Accounts.User

  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Reactor.PubSub, @topic)
  end

  def subscribe(user_id) do
    Phoenix.PubSub.subscribe(Reactor.PubSub, @topic <> "#{user_id}")
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:user, :created])
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:user, :updated])
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
    |> notify_subscribers([:user, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Reactor.PubSub, @topic, {__MODULE__, event, result})

    Phoenix.PubSub.broadcast(
      Reactor.PubSub,
      @topic <> "#{result.id}",
      {__MODULE__, event, result}
    )

    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _), do: {:error, reason}

  def authenticate_by_email_password(email, given_pass) do
    user = get_user_by_email(email)

    cond do
      email in Reactor.Accounts.Email.banned() ->
        dummy_checkpw()
        {:error, :unauthorized}

      user && checkpw(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        dummy_checkpw()
        {:error, :not_found}
    end
  end

  def authenticate_by_email_token(email, token) do
    user = get_user_by_email(email)

    cond do
      email in Reactor.Accounts.Email.banned() ->
        dummy_checkpw()
        {:error, :unauthorized}

      user && user.login_token && checkpw(token, user.login_token) ->
        update_login_token(user, nil)
        {:ok, user}

      true ->
        dummy_checkpw()
        {:error, :unauthorized}
    end
  end

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def update_login_token(%User{} = user, token) do
    user
    |> User.token_changeset(%{login_token: token})
    |> Repo.update()
  end
end
