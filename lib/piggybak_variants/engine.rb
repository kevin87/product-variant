module PiggybakVariants
  class Engine < ::Rails::Engine
    isolate_namespace PiggybakVariants

    config.to_prepare do
      ApplicationController.class_eval do
        helper :piggybak_variants
      end
      RailsAdmin::ApplicationController.class_eval do
        helper :piggybak_variants
      end
    end

    initializer "piggybak_variants.assets.precompile" do |app|
      app.config.assets.precompile += ['piggybak_variants/piggybak_variants-application.js']
    end

    # TODO: Figure out of we can have this only in to_prepare or here
    initializer "piggybak_variants.add_helper" do |app|
      ApplicationController.class_eval do
        helper :piggybak_variants
      end
    end

    initializer "piggybak.rails_admin_config" do |app|
      RailsAdmin.config do |config|
        config.model PiggybakVariants::OptionConfiguration do
          visible false
          object_label_method :admin_label
          label "Classes with Option"
          edit do
            field :klass
          end
        end

        config.model PiggybakVariants::OptionValue do
          visible false
          object_label_method :admin_label
          edit do
            field :name
            field :position
          end
        end

        config.model PiggybakVariants::Option do
          navigation_label "Product"
          list do
            field :name
            field :position
            field :option_values
            field :option_configurations do
              label "Classes with Option"
            end
          end
          edit do
            field :name
            field :position
            field :option_configurations do
              label "Classes with Option"
              active true
            end
            field :option_values do
              active true
            end
          end
        end

        config.model PiggybakVariants::Sellable do
          label "Sellable"
          visible false
          edit do
            field :sku
            field :description
            field :price
            field :active
            field :quantity
            field :product_weight
            field :product_height
            field :product_width
            field :product_length
            field :unlimited_inventory do
              help "If true, backorders on this variant will be allowed, regardless of quantity on hand."
            end
          end
        end

        config.model PiggybakVariants::Variant do
          navigation_label "Product"
          object_label_method :admin_label
          show do
            field :option_values do
              visible true
            end
          end
          edit do
            field :option_values do
              partial "option_values"
              help "An option value for each option must be selected"
            end
            field :piggybak_variants_sellable do
              active true
            end
          end
        end
      end
    end
  end
end
