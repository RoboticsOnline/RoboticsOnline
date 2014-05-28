json.array!(@messages) do |message|
  json.extract! message, :id, :from_user, :to_user, :title, :content, :published_at, :unread
  json.url message_url(message, format: :json)
end
