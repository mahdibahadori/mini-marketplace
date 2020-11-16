class ChangeValuesInItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :name, :string, false
    change_column_null :items, :description, :string,  false
    change_column_null :items, :price, :integer, false
  end
end
