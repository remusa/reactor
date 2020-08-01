defmodule ReactorWeb.PodcastView do
  use ReactorWeb, :view

  def comment_count_str(n) do
    case n do
      0 -> "(No comments)"
      1 -> "(1 comment)"
      n -> "(#{n} comments)"
    end
  end
end
