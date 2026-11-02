class AddIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :products, [:title,:description], type: :fulltext
  end
end
