#Steps
In this project write a scraper to fetch the data from amazon site.
For fetching purpose using Nokogiri and ProxyCrawler.
#Steps=1
1. Clone/fork this repository.
2. `cd path/to/repo`
3. `rails db:create`
4. `rails db:migrate`
5. `rails db:seed`
In Seed file set the user email and website url once the seed successfully created then goto the postman follow the apidoc using sign in api to get the auth_token.Based on auth_token you can get the further api's 
#Steps=2
I'm using whenever gem to add the cron jobs
#Steps=3
1. Start rails server with `rails s`
2. Go to `http://localhost:3000/apidoc`
#Steps=4
I'm using sidekiq you will need to run ` bundle exec sidekiq`

