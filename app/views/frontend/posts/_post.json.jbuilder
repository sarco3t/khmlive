json.(post, *post.attributes.except(:created_at).keys)
json.created_at time_ago_in_words(post.created_at)
json.url category_post_url(post.category, post.id)
json.has_like !!current_user && !!(post.likes.find_by(user: current_user))
json.images post.images.map { |image| url_for(image) }
json.comments do
  json.array! post.comments.page(1), partial: 'frontend/comments/comment', as: :comment
end
json.category do
  json.partial! 'frontend/categories/category', category: post.category
end
