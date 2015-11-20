shared_context "shared model classes context" do
  class ModelName
    def initialize(klass)
      @klass = klass
    end

    # taken from: http://stackoverflow.com/questions/5622435/how-do-i-convert-a-ruby-class-name-to-a-underscore-delimited-symbol
    def underscore(word)
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
    end

    def i18n_key
      underscore(@klass.name).to_sym
    end
  end

  class Tableless
    def self.model_name
      ModelName.new(self)
    end
  end

  class AttributeTest < Tableless    
    include AttrEffective 
    attr_accessor :value
    attr_effective :value
  end

  class AttributeTestOpts < AttributeTest
    def attr_effective_default_opts
      {company_name: "Acme"}
    end
  end

  class AttributeTestDefault < AttributeTest    
    def value_default
      "DEFAULT"
    end
  end
end