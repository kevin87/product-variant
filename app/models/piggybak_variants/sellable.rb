module PiggybakVariants
  class Sellable < ActiveRecord::Base
    belongs_to :item, :polymorphic => true, :inverse_of => :piggybak_variants_sellable

    validates :sku, presence: true, uniqueness: true
    validates :description, presence: true
    validates :price, presence: true
    validates :item_type, presence: true
    validates_numericality_of :quantity, :only_integer => true, :greater_than_or_equal_to => 0

    def admin_label
      self.description
    end

    def update_inventory(purchased)
      self.update_attribute(:quantity, self.quantity + purchased)
    end
  end
end
