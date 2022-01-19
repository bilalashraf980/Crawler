module Api
  module V1
    class ScrapersController < ApiProtectedController
      
      before_action :set_scraper, only: [:show, :update, :destroy]
      
      api :GET, '/v1/scrapers.json', "Scrapers"
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
          "scrapers":[
            {
              "id": 1,
              "website_url":  "https://www.amazon.com/s?k=macbook&crid=3SA3UWXRLK3J7&sprefix=mac%2Caps%2C431&ref=nb_sb_ss_ts-doa-p_4_3"
            },
            {
              "id": 5,
              "website_url":  "https://www.amazon.com/s?k=macbook&crid=3SA3UWXRLK3J7&sprefix=mac%2Caps%2C431&ref=nb_sb_ss_ts-doa-p_4_3"
            }
            
          ]
        }

        422: {"message": "Record not found"}

        403: {"message": "Missing parameters"}

        401: {"message": "Your session expired. Please login again."}

      EOS
      
      def index
        @scrapers = Scraper.all
      end
      
      api :POST, '/v1/scrapers.json', "Scrapers"
      formats ['json']
      example <<-EOS
      
      Request:
        {
          "scrapers":{
            "website_url":  "https://www.amazon.com/s?k=macbook&crid=3SA3UWXRLK3J7&sprefix=mac%2Caps%2C431&ref=nb_sb_ss_ts-doa-p_4_3"
          }
        }
      
        Header: {
          "AUTH-TOKEN": "xxxxxxx",
          "Content-Type": "application/json"
        }

        Status Codes with Response
        200: {
          "scrapers":
            {
              "id": 1,
              "website_url":  "https://www.amazon.com/s?k=macbook&crid=3SA3UWXRLK3J7&sprefix=mac%2Caps%2C431&ref=nb_sb_ss_ts-doa-p_4_3"
            }
          
        }

        422: {"message": "Record not found"}

        403: {"message": "Missing parameters"}

        401: {"message": "Your session expired. Please login again."}

      EOS
      
      param :scraper, Hash, desc: 'Scraper Creation', required: true do
        param :website_url, String, desc: 'Website Url'
      end
      
      def create
        @scraper = Scraper.new(scraper_params)
        if @scraper.save
          render template: "/api/v1/scrapers/show"
        else
          render json: {errors: @scraper.errors.full_messages}, status: 422
        end
      end
      
      api :PUT, '/v1/scrapers/{id}.json', 'Update Scraper'
      formats ['json']
      example <<-EOS
      
      Scraper Request:
        {
          "scrapers":{
            "website_url":  "https://www.amazon.com/s?k=macbook&crid=3SA3UWXRLK3J7&sprefix=mac%2Caps%2C431&ref=nb_sb_ss_ts-doa-p_4_3"
          }
        }
      
        Header: {
          "AUTH-TOKEN": "xxxxxxx",
          "Content-Type": "application/json"
        }

        Status Codes with Response
        200: {
          "scrapers":
            {
              "id": 1,
              "website_url":  "https://www.amazon.com/s?k=macbook&crid=3SA3UWXRLK3J7&sprefix=mac%2Caps%2C431&ref=nb_sb_ss_ts-doa-p_4_3"
            }
          
        }

        422: {"message": "Record not found"}

        403: {"message": "Missing parameters"}

        401: {"message": "Your session expired. Please login again."}

      EOS
      
      param :scraper, Hash, desc: 'Scraper Updation', required: true do
        param :website_url, String, desc: 'Website Url'
      end
      
      def update
        if @scraper.update(scraper_params)
          render template: "/api/v1/scrapers/show"
        else
          render json: {errors: @scraper.errors.full_messages}, status: 422
        end
      end
      
      api :GET, '/v1/scrapers/{id}.json', 'Get Scraper'
      formats ['json']
      example <<-EOS
      
      Scraper Request:
        {
        }
      
        Header: {
          "AUTH-TOKEN": "xxxxxxx",
          "Content-Type": "application/json"
        }

        Status Codes with Response
        200: {
          "scrapers":
            {
              "id": 1,
              "website_url":  "https://www.amazon.com/s?k=macbook&crid=3SA3UWXRLK3J7&sprefix=mac%2Caps%2C431&ref=nb_sb_ss_ts-doa-p_4_3"
            }
        }

        422: {"message": "Record not found"}

        403: {"message": "Missing parameters"}

        401: {"message": "Your session expired. Please login again."}

      EOS
      
      param :id, Integer, desc: 'Scraper id'
      
      def show
      end
      
      api :DELETE, '/v1/scrapers/{id}.json', 'Delete Scraper'
      formats ['json']
      example <<-EOS
      
      Scraper Request:
        {
        }
      
        Header: {
          "AUTH-TOKEN": "xxxxxxx",
          "Content-Type": "application/json"
        }

        Status Codes with Response
        200: {
          message: "Page successfully deleted"
        }

        422: {"message": "Page not found"}

        403: {"message": "Missing parameters"}

        401: {"message": "Your session expired. Please login again."}

      EOS
      
      param :id, Integer, desc: 'Scraper id'
      
      def destroy
        if @scraper.destroy
          render json: {message: "Page successfully deleted"}
        else
          render json: {errors: @scraper.errors.full_messages}, status: 422
        end
      end
      private
      
      def set_scraper
        @scraper = Scraper.find params[:id]
      end
      
      def scraper_params
        params.require(:scrapers).permit(:website_url)
      end
    end
  end
end

