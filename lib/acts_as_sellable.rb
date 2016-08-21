module Piggybak
  module ActsAsSellable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_sellable
        has_one :piggybak_variants_sellable, :as => "item", :class_name => "::PiggybakVariants::Sellable", :inverse_of => :item
        accepts_nested_attributes_for :piggybak_variants_sellable, :allow_destroy => true
      end
    end
  end
end

::ActiveRecord::Base.send :include, Piggybak::ActsAsSellable
