defmodule Reactor.Content.Podcast do
  use Ecto.Schema
  import Ecto.Changeset

  schema "podcasts" do
    field :audio_url, :string
    field :is_published, :boolean, default: false
    field :notes_md, :string
    field :subtitle, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(podcast, attrs) do
    podcast
    |> cast(attrs, [:audio_url, :is_published, :notes_md, :subtitle, :title])
    |> validate_required([:audio_url, :notes_md, :subtitle, :title])
    |> unique_constraint(:title)
    |> gen_notes()
  end

  defp gen_notes(%{valid?: true, changes: %{notes_md: text}} = changeset) do
    put_change(changeset, :notes_html, AlchemistMarkdown.to_html(text))
  end

  defp gen_notes(changeset), do: changeset
end
