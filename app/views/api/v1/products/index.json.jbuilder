json.products do
  json.array! @products do |product|
    json.name                     product.name
    json.price                    product.price
    json.customer_review          product.customer_review
    json.customer_review_count    product.customer_review_count
    json.shipping_message         product.shipping_message
    json.asin                     product.asin
    json.image                    product.image
    json.url                      product.url
    json.is_prime                 product.is_prime
    json.is_sponsored_ad          product.is_sponsored_ad
  end
end
