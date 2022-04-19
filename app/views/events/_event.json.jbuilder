json.extract! event, :id, :name, :date, :description, :online_InPerson, :post_permission, :invite_permission, :location, :created_at, :updated_at
json.url event_url(event, format: :json)
