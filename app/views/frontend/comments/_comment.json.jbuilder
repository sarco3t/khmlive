if comment.errors.blank?
  json.(comment, *comment.attributes.except(:created_at).keys)
  json.created_at time_ago_in_words(comment.created_at)
  # json.body Emoji.replace_unicode_moji_with_images(comment.body)
  json.user do
    json.partial! 'frontend/users/user', resource: comment.user
  end
  json.has_like !!current_user && !!(comment.likes.find_by(user: current_user))
  json.url comment_path(comment)
else
  json.errors comment.errors
end
