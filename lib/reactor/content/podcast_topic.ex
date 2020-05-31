defmodule Reactor.Content.PodcastTopic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "podcast_topics" do
    field :podcast_id, :id
    field :topic_id, :id

    timestamps()
  end

  @doc false
  def changeset(podcast_topic, attrs) do
    podcast_topic
    |> cast(attrs, [])
    |> validate_required([])
  end
end
