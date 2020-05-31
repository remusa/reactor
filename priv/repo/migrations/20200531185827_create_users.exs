defmodule Reactor.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :is_verified, :boolean, default: false, null: false
      add :password_hash, :string
      add :website, :string

      timestamps()
    end

    create index(:users, [:name])
    create unique_index(:users, [:email])
  end
end
