defmodule Reactor.Repo.Migrations.AddLoginhashtoUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :login_token, :string
    end
  end
end
