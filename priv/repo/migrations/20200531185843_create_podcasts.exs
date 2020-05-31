defmodule Reactor.Repo.Migrations.CreatePodcasts do
  use Ecto.Migration

  def change do
    create table(:podcasts) do
      add :audio_url, :string
      add :is_published, :boolean, default: false, null: false
      add :notes_md, :text
      add :subtitle, :string
      add :title, :string

      timestamps()
    end

    create unique_index(:podcasts, [:title])
  end
end
