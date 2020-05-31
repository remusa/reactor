defmodule Reactor.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Reactor.Repo

  alias Reactor.Content.Podcast

  @doc """
  Returns the list of podcasts.

  ## Examples

      iex> list_podcasts()
      [%Podcast{}, ...]

  """
  def list_podcasts do
    Repo.all(Podcast)
  end

  @doc """
  Gets a single podcast.

  Raises `Ecto.NoResultsError` if the Podcast does not exist.

  ## Examples

      iex> get_podcast!(123)
      %Podcast{}

      iex> get_podcast!(456)
      ** (Ecto.NoResultsError)

  """
  def get_podcast!(id), do: Repo.get!(Podcast, id)

  @doc """
  Creates a podcast.

  ## Examples

      iex> create_podcast(%{field: value})
      {:ok, %Podcast{}}

      iex> create_podcast(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_podcast(attrs \\ %{}) do
    %Podcast{}
    |> Podcast.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a podcast.

  ## Examples

      iex> update_podcast(podcast, %{field: new_value})
      {:ok, %Podcast{}}

      iex> update_podcast(podcast, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_podcast(%Podcast{} = podcast, attrs) do
    podcast
    |> Podcast.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a podcast.

  ## Examples

      iex> delete_podcast(podcast)
      {:ok, %Podcast{}}

      iex> delete_podcast(podcast)
      {:error, %Ecto.Changeset{}}

  """
  def delete_podcast(%Podcast{} = podcast) do
    Repo.delete(podcast)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking podcast changes.

  ## Examples

      iex> change_podcast(podcast)
      %Ecto.Changeset{data: %Podcast{}}

  """
  def change_podcast(%Podcast{} = podcast, attrs \\ %{}) do
    Podcast.changeset(podcast, attrs)
  end

  alias Reactor.Content.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end

  alias Reactor.Content.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{data: %Topic{}}

  """
  def change_topic(%Topic{} = topic, attrs \\ %{}) do
    Topic.changeset(topic, attrs)
  end

  alias Reactor.Content.PodcastTopic

  @doc """
  Returns the list of podcast_topics.

  ## Examples

      iex> list_podcast_topics()
      [%PodcastTopic{}, ...]

  """
  def list_podcast_topics do
    Repo.all(PodcastTopic)
  end

  @doc """
  Gets a single podcast_topic.

  Raises `Ecto.NoResultsError` if the Podcast topic does not exist.

  ## Examples

      iex> get_podcast_topic!(123)
      %PodcastTopic{}

      iex> get_podcast_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_podcast_topic!(id), do: Repo.get!(PodcastTopic, id)

  @doc """
  Creates a podcast_topic.

  ## Examples

      iex> create_podcast_topic(%{field: value})
      {:ok, %PodcastTopic{}}

      iex> create_podcast_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_podcast_topic(attrs \\ %{}) do
    %PodcastTopic{}
    |> PodcastTopic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a podcast_topic.

  ## Examples

      iex> update_podcast_topic(podcast_topic, %{field: new_value})
      {:ok, %PodcastTopic{}}

      iex> update_podcast_topic(podcast_topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_podcast_topic(%PodcastTopic{} = podcast_topic, attrs) do
    podcast_topic
    |> PodcastTopic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a podcast_topic.

  ## Examples

      iex> delete_podcast_topic(podcast_topic)
      {:ok, %PodcastTopic{}}

      iex> delete_podcast_topic(podcast_topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_podcast_topic(%PodcastTopic{} = podcast_topic) do
    Repo.delete(podcast_topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking podcast_topic changes.

  ## Examples

      iex> change_podcast_topic(podcast_topic)
      %Ecto.Changeset{data: %PodcastTopic{}}

  """
  def change_podcast_topic(%PodcastTopic{} = podcast_topic, attrs \\ %{}) do
    PodcastTopic.changeset(podcast_topic, attrs)
  end
end
