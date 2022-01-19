task :crawler => :environment do
  
  puts "Rake task crawls the data from the website"
  Scraper.all.each do |page_data|
    puts "Website url  #{page_data.website_url}"
    CrawlWorker.perform_async(page_data.website_url)
  end
  
end