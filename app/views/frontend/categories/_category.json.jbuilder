json.(category, *category.attributes.keys)
json.logo_url url_for(category.logo) if category.logo
json.url category_posts_url(category)
