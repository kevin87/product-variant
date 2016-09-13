module PiggybakVariants
  class Variant < ActiveRecord::Base
    acts_as_sellable
    belongs_to :item, :polymorphic => true
    has_and_belongs_to_many :option_values, :class_name => "::PiggybakVariants::OptionValue"
    has_many :options, :through => :option_values

    scope :available, -> { joins(:piggybak_variants_sellable).where(["piggybak_variants_sellables.active = ? AND (piggybak_variants_sellables.quantity > 0 OR piggybak_variants_sellables.unlimited_inventory = ?)",true,true]) } 
    validate :option_value_validation
    validate :require_item

    def admin_label
      "#{self.piggybak_variants_sellable.try(:sku)}: #{self.piggybak_variants_sellable.try(:price)}"
    end

    def require_item
      self.errors.add(:piggybak_variants_sellable, "You must have foo") if self.piggybak_variants_sellable.nil?
    end

    def option_value_validation
      # TODO: Add verification to prevent duplicate option value sets

      klass = self.item.class
      options = ::PiggybakVariants::OptionConfiguration.where(klass: klass).collect { |oc| oc.option }
      error = false
      options.each do |option|
        matching_option_values = self.option_values.select { |ov| ov.option == option }.size
        if matching_option_values > 1
          self.errors.add(:option_values, "You must have only option value for #{option.name}")
          error = true
        elsif matching_option_values < 1
          self.errors.add(:option_values, "You must have one option value for #{option.name}")
          error = true
        end
      end
      self.errors.add(:base, "Option value errors") if error
    end
  end
end
