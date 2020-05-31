defmodule Reactor.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :is_verified, :boolean, default: false
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :is_verified, :password_hash, :website])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_format(:website, ~r/https?\:\/\//, message: "Must be a URL")
    |> unique_constraint(:email)
  end
end
