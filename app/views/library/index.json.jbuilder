json.array!(@pages) do |page|
  json.extract! page, :id, :name, :content, :content_raw, :shared_id, :user_id
  json.url page_url(page, format: :json)
end
