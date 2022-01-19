json.scrapers do
  json.array! @scrapers do |scraper|
    json.partial! "scraper", scraper: scraper
  end
end