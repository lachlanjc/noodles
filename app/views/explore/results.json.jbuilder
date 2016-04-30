json.results @results do |result|
  json.title result['title']
  json.description result['description']
  json.url result['url']
  json.image result['image'] if result['image'].present?
end
