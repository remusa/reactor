defmodule Reactor.Repo.Migrations.CreatePodcastTopics do
  use Ecto.Migration

  def change do
    create table(:podcast_topics) do
      add :podcast_id, references(:podcasts, on_delete: :delete_all)
      add :topic_id, references(:topics, on_delete: :delete_all)

      timestamps()
    end

    create index(:podcast_topics, [:podcast_id])
    create index(:podcast_topics, [:topic_id])
    create index(:podcast_topics, [:podcast_id, :topic_id])
  end
end
