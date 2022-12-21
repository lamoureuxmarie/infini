class RemoveSubscribableFromSpreeProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :spree_products, :subscribable, :boolean
  end
end
