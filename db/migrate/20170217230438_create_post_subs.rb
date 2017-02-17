class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|

      t.timestamps null: false
    end
  end
end
