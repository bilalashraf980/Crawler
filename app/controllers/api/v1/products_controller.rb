module Api
  module V1
    class ProductsController < ApiProtectedController
  
      api :GET, '/v1/products.json', "Products "
      formats ['json']
      example <<-EOS
      
      Request:
        {
        }
      
        Header: {
          "AUTH-TOKEN": "xxxxxxx",
          "Content-Type": "application/json"
        }

        Status Codes with Response
        200: {
          "products":[
            {
              "id": 1,
              "name":                    "xxxxxxx",
              "price":                    "xxxxxxx"
              "customer_review":          "xxxxxxx"
              "customer_review_count":    "xxxxxxx"
              "shipping_message":         "xxxxxxx"
              "asin":                     "xxxxxxx"
              "image":                    "xxxxxxx"
              "url":                      "xxxxxxx"
              "is_prime":                 "xxxxxxx"
              "is_sponsored_ad":          "xxxxxxx"
            },
            {
              "id": 2,
              "name":                    "xxxxxxx",
              "price":                    "xxxxxxx"
              "customer_review":          "xxxxxxx"
              "customer_review_count":    "xxxxxxx"
              "shipping_message":         "xxxxxxx"
              "asin":                     "xxxxxxx"
              "image":                    "xxxxxxx"
              "url":                      "xxxxxxx"
              "is_prime":                 "xxxxxxx"
              "is_sponsored_ad":          "xxxxxxx"
            }
            
          ]
        }
        422: {"message": "Products not found"}

        403: {"message": "Missing parameters"}

        400: {"message": "xxxxxxxxxx"}

        401: {"message": "Your session expired. Please login again."}

      EOS
      
      def index
        @products = Product.all
      end
      
    end
  end
end

