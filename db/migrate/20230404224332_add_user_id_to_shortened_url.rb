class AddUserIdToShortenedUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :shortened_urls, :user_id, :integer
  end
end
