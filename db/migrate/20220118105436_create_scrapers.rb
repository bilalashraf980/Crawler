class CreateScrapers < ActiveRecord::Migration[7.0]
  def change
    create_table :scrapers do |t|
      t.string   :website_url
      t.timestamps
    end
  end
end
