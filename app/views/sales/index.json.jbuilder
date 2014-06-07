json.array!(@sales) do |sale|
  json.extract! sale, :id, :url, :picture
  json.url sale_url(sale, format: :json)
end
