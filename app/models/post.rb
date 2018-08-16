# frozen_string_literal: true

class Post < AbstractPost
  def slug_candidates
    [
      :title,
      %i[title id]
    ]
  end
end
