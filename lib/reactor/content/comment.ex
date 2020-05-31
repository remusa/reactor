defmodule Reactor.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :html, :string
    field :is_flagged, :boolean, default: false
    field :is_published, :boolean, default: false
    field :markdown, :string
    field :podcast_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:is_published, :is_flagged, :html, :markdown])
    |> validate_required([:is_published, :is_flagged, :html, :markdown])
  end
end
