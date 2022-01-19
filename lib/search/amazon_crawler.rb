module Search::AmazonCrawler
  require 'proxycrawl'
  require 'open-uri'
  require 'nokogiri'
  require 'json'

  ORIGINAL_STATUSES = [200, 201, 204, 301]
  PC_STATUSES       = [200]
  
  def self.get_products(url)
    begin
      api = ProxyCrawl::ScraperAPI.new(token: ENV['ENV_PROXY_CRAWL_NORMAL_TOKEN'])
      response = api.get(url)
      response_body = JSON.parse response.body
      if ORIGINAL_STATUSES.include?(response_body['original_status']) || PC_STATUSES.include?(response_body['pc_status'])
        products = self.get_products_html(url,response_body["body"]["products"])
        self.create_products(products)
      else
        puts response_body["body"]
        return []
      end
    rescue Exception => e
      puts e.message
    end
  end

  def self.get_products_html(url,products=[])
    begin
      @uri = URI url
      header = { "User-Agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36", "Accept"=>"text/html" }
      document_html = Nokogiri::HTML(URI.open(url,header))
      document_html.css(".s-result-item").each do |search_result_item|
        unless search_result_item.attr("data-asin").blank?
          document_html_parse_data = {
              "name"                  => search_result_item.at(".a-text-normal")&.text&.strip,
              "asin"                  => search_result_item.attr("data-asin")&.strip,
              "image"                 => search_result_item.css("img").attr("src")&.value&.strip,
              "price"                 => search_result_item.css(".a-offscreen")&.text&.strip,
              "customerReview"        =>  search_result_item.at(".a-size-small span")&.text&.strip,
              "customerReviewCount"   => search_result_item.at("span.a-size-base")&.text.to_s.gsub(",","").to_i,
              "url"                   => @uri.scheme + "://"+@uri.host+search_result_item.at(".a-link-normal").attr("href"),
              "shippingMessage"       => search_result_item.at(".a-color-secondary span")&.text,
              "isPrime"               => false,
              "sponsoredAd"           => false
          }
          products <<  document_html_parse_data
        end
      end
      if document_html.at("li.a-last a").present?
        @uri = URI @uri.scheme + "://"+@uri.host+document_html.at("li.a-last a").attr("href")
        self.get_products_html(url,products)
      end
      products
    rescue Exception => e
      puts e.message
    end
  end

  def self.create_products(products)
    begin
      products&.each do |p|
        Rails.logger.info p
        product = Product.find_or_initialize_by(asin: p["asin"])
        unless product.persisted?
          product.name                  = p["name"]
          product.price                 = p["price"]
          product.customer_review       = p["customerReview"]
          product.customer_review_count = p["customerReviewCount"]
          product.shipping_message      = p["shippingMessage"]
          product.asin                  = p["asin"]
          product.url                   = p["url"]
          product.is_prime              = p["isPrime"]
          product.is_sponsored_ad       = p["sponsoredAd"]
          product.save
        end
      end
    rescue Exception => e
      puts e.message
    end
  end
end