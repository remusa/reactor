defmodule Reactor.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :is_published, :boolean, default: false, null: false
      add :is_flagged, :boolean, default: false, null: false
      add :html, :text
      add :markdown, :text
      add :podcast_id, references(:podcasts, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:comments, [:podcast_id])
    create index(:comments, [:user_id])
  end
end
