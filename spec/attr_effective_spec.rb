require 'spec_helper'

describe AttrEffective do
  
  include_context "shared model classes context"

  before(:each) {
    allow(I18n).to receive(:t).with("activerecord.defaults.attribute_test.value", {}).and_return("locale-value")
  }

  describe "#test_effective" do
    context "default" do
      subject { AttributeTestDefault.new }
      it "returns default when value not set" do
        expect(subject.value_effective).to eq("DEFAULT")
      end
      it "returns value when set" do
        subject.value = "VALUE"
        expect(subject.value_effective).to eq("VALUE")
      end
    end
    context "without default" do
      subject { AttributeTest.new }
      it "returns default from locale when value not set" do
        expect(subject.value_effective).to eq("locale-value")
      end
      it "returns value when set" do
        subject.value = "VALUE"
        expect(subject.value_effective).to eq("VALUE")
      end
    end
    context "with default options method" do
      subject { AttributeTestOpts.new }
      it "passes options to translate" do
        allow(I18n).to receive(:t).with("activerecord.defaults.attribute_test_opts.value", {:company_name=>"Acme"}).and_return("locale-value-opts")
        expect(subject.value_effective).to eq("locale-value-opts")
      end
    end
  end
  describe "::i18n_default_path" do
    it "returns expected path" do
      expect(AttributeTest.i18n_default_path(:value)).to eq("activerecord.defaults.attribute_test.value")
    end
  end
  describe "::i18n_default" do
    it "returns expected path" do
      expect(AttributeTest.i18n_default(:value)).to eq("locale-value")
    end
  end
  describe "#i18n_default_path" do
    it "returns expected path" do
      expect(AttributeTest.new.i18n_default_path(:value)).to eq("activerecord.defaults.attribute_test.value")
    end
  end
  describe "#i18n_default" do
    it "returns expected path" do
      expect(AttributeTest.new.i18n_default(:value)).to eq("locale-value")
    end
  end
end
