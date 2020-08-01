defmodule ReactorWeb.CommentView do
  use ReactorWeb, :view
  alias ReactorWeb.Endpoint

  def comment_url(comment = %Reactor.Content.Comment{}) do
    Routes.podcast_path(Endpoint, :show, comment.podcast_id) <>
      "#comment-#{comment.id}"
  end
end
