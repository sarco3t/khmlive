if comment.errors.blank?
  json.(comment, *comment.attributes.except(:created_at).keys)
  json.created_at time_ago_in_words(comment.created_at)
  json.user do
    json.partial! 'frontend/users/user', resource: comment.user
  end
else
  json.errors comment.errors
end
