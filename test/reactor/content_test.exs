defmodule Reactor.ContentTest do
  use Reactor.DataCase

  alias Reactor.Content

  describe "podcasts" do
    alias Reactor.Content.Podcast

    @valid_attrs %{audio_url: "some audio_url", is_published: true, notes_md: "some notes_md", subtitle: "some subtitle", title: "some title"}
    @update_attrs %{audio_url: "some updated audio_url", is_published: false, notes_md: "some updated notes_md", subtitle: "some updated subtitle", title: "some updated title"}
    @invalid_attrs %{audio_url: nil, is_published: nil, notes_md: nil, subtitle: nil, title: nil}

    def podcast_fixture(attrs \\ %{}) do
      {:ok, podcast} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_podcast()

      podcast
    end

    test "list_podcasts/0 returns all podcasts" do
      podcast = podcast_fixture()
      assert Content.list_podcasts() == [podcast]
    end

    test "get_podcast!/1 returns the podcast with given id" do
      podcast = podcast_fixture()
      assert Content.get_podcast!(podcast.id) == podcast
    end

    test "create_podcast/1 with valid data creates a podcast" do
      assert {:ok, %Podcast{} = podcast} = Content.create_podcast(@valid_attrs)
      assert podcast.audio_url == "some audio_url"
      assert podcast.is_published == true
      assert podcast.notes_md == "some notes_md"
      assert podcast.subtitle == "some subtitle"
      assert podcast.title == "some title"
    end

    test "create_podcast/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_podcast(@invalid_attrs)
    end

    test "update_podcast/2 with valid data updates the podcast" do
      podcast = podcast_fixture()
      assert {:ok, %Podcast{} = podcast} = Content.update_podcast(podcast, @update_attrs)
      assert podcast.audio_url == "some updated audio_url"
      assert podcast.is_published == false
      assert podcast.notes_md == "some updated notes_md"
      assert podcast.subtitle == "some updated subtitle"
      assert podcast.title == "some updated title"
    end

    test "update_podcast/2 with invalid data returns error changeset" do
      podcast = podcast_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_podcast(podcast, @invalid_attrs)
      assert podcast == Content.get_podcast!(podcast.id)
    end

    test "delete_podcast/1 deletes the podcast" do
      podcast = podcast_fixture()
      assert {:ok, %Podcast{}} = Content.delete_podcast(podcast)
      assert_raise Ecto.NoResultsError, fn -> Content.get_podcast!(podcast.id) end
    end

    test "change_podcast/1 returns a podcast changeset" do
      podcast = podcast_fixture()
      assert %Ecto.Changeset{} = Content.change_podcast(podcast)
    end
  end

  describe "comments" do
    alias Reactor.Content.Comment

    @valid_attrs %{html: "some html", is_flagged: true, is_published: true, markdown: "some markdown"}
    @update_attrs %{html: "some updated html", is_flagged: false, is_published: false, markdown: "some updated markdown"}
    @invalid_attrs %{html: nil, is_flagged: nil, is_published: nil, markdown: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Content.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Content.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Content.create_comment(@valid_attrs)
      assert comment.html == "some html"
      assert comment.is_flagged == true
      assert comment.is_published == true
      assert comment.markdown == "some markdown"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Content.update_comment(comment, @update_attrs)
      assert comment.html == "some updated html"
      assert comment.is_flagged == false
      assert comment.is_published == false
      assert comment.markdown == "some updated markdown"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_comment(comment, @invalid_attrs)
      assert comment == Content.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Content.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Content.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Content.change_comment(comment)
    end
  end

  describe "topics" do
    alias Reactor.Content.Topic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Content.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Content.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Content.create_topic(@valid_attrs)
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{} = topic} = Content.update_topic(topic, @update_attrs)
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_topic(topic, @invalid_attrs)
      assert topic == Content.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Content.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Content.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Content.change_topic(topic)
    end
  end

  describe "podcast_topics" do
    alias Reactor.Content.PodcastTopic

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def podcast_topic_fixture(attrs \\ %{}) do
      {:ok, podcast_topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_podcast_topic()

      podcast_topic
    end

    test "list_podcast_topics/0 returns all podcast_topics" do
      podcast_topic = podcast_topic_fixture()
      assert Content.list_podcast_topics() == [podcast_topic]
    end

    test "get_podcast_topic!/1 returns the podcast_topic with given id" do
      podcast_topic = podcast_topic_fixture()
      assert Content.get_podcast_topic!(podcast_topic.id) == podcast_topic
    end

    test "create_podcast_topic/1 with valid data creates a podcast_topic" do
      assert {:ok, %PodcastTopic{} = podcast_topic} = Content.create_podcast_topic(@valid_attrs)
    end

    test "create_podcast_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_podcast_topic(@invalid_attrs)
    end

    test "update_podcast_topic/2 with valid data updates the podcast_topic" do
      podcast_topic = podcast_topic_fixture()
      assert {:ok, %PodcastTopic{} = podcast_topic} = Content.update_podcast_topic(podcast_topic, @update_attrs)
    end

    test "update_podcast_topic/2 with invalid data returns error changeset" do
      podcast_topic = podcast_topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_podcast_topic(podcast_topic, @invalid_attrs)
      assert podcast_topic == Content.get_podcast_topic!(podcast_topic.id)
    end

    test "delete_podcast_topic/1 deletes the podcast_topic" do
      podcast_topic = podcast_topic_fixture()
      assert {:ok, %PodcastTopic{}} = Content.delete_podcast_topic(podcast_topic)
      assert_raise Ecto.NoResultsError, fn -> Content.get_podcast_topic!(podcast_topic.id) end
    end

    test "change_podcast_topic/1 returns a podcast_topic changeset" do
      podcast_topic = podcast_topic_fixture()
      assert %Ecto.Changeset{} = Content.change_podcast_topic(podcast_topic)
    end
  end
end
