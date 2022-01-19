class CrawlWorker
  include Sidekiq::Worker
  
  def perform(url)
    Search::AmazonCrawler.get_products(url)
  end
end
