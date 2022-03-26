json.extract! post, :id, :text, :image, :created_at, :updated_at
json.url post_url(post, format: :json)
json.image url_for(post.image)
