class AddNotNullToItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :name, :string, null: false
    change_column_null :items, :description, :string,  null: false
    change_column_null :items, :price, :integer, null: false
  end
end
