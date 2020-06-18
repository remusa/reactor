defmodule Reactor.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Argon2

  schema "users" do
    field :email, :string
    field :is_verified, :boolean, default: false
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :login_token, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :is_verified, :website])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_format(:website, ~r/https?\:\/\//, message: "Must be a URL")
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, attrs \\ %{}) do
    struct
    |>changeset(attrs)
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> hash_login_token()
  end

  def token_changeset(struct, attrs \\ %{}) do
    struct
    |> changeset(attrs)
    |> cast(attrs, [:login_token])
    |> hash_login_token()
  end

  def generate_login_token do
    :crypto.strong_rand_bytes(40) |> Base.url_encode64()
  end

  defp hash_login_token(%{valid?: false} = changeset), do: changeset

  defp hash_login_token(%{changes: %{login_token: nil}} = changeset) do
    put_change(changeset, :login_token, nil)
  end

  defp hash_login_token(%{changes: %{login_token: token}} = changeset) do
    put_change(changeset, :login_token, Argon2.hashpwsalt(token))
  end

  defp hash_login_token(%{valid?: true} = changeset), do: put_change(changeset, :login_token, nil)

  defp hash_password(%{valid?: false} = changeset), do: changeset

  defp hash_password(%{valid?: true, changes: %{password: password}} = changeset)   do
    put_change(changeset, :password_hash, Argon2.hashpwsalt(password))
  end
end
