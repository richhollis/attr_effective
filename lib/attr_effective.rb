require "attr_effective/version"
require 'active_support/concern'
require 'i18n'

module AttrEffective
  extend ActiveSupport::Concern

  def i18n_default_path(attr)
    self.class.i18n_default_path(attr)
  end

  def i18n_default(attr, opts = {})
    I18n.t(self.class.i18n_default_path(attr), opts)
  end

  module ClassMethods
    def attr_effective(*attrs)
      attrs.each do |attr|
        # define the effective method
        define_method("#{attr}_effective") do
          self.send(attr) || self.send("#{attr}_default")
        end
        # define the default method - if it doesn't already exist
        unless self.method_defined?("#{attr}_default".to_sym)
          define_method("#{attr}_default") do
            opts = self.class.method_defined?(:attr_effective_default_opts) ? self.attr_effective_default_opts : {}
            i18n_default(attr, opts)
          end
        end
      end
    end

    def i18n_default(attr, opts = {})
      I18n.t(self.i18n_default_path(attr), opts)
    end

    def i18n_default_path(attr)
      "activerecord.defaults.#{self.model_name.i18n_key}.#{attr}"
    end
  end
end