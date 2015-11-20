# attr_effective

Effective values for rails model attributes using a default value from a model method or I18n string

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attr_effective'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_effective

## Usage

Create an initializer and extend ActiveRecord with the concern

initializers/attr_effective.rb:

```ruby
ActiveRecord::Base.send :include, AttrEffective
```

You are now ready to use the class attribute:


```ruby
class MyModel
  attr_accessible :value
  attr_effective :value

  # If this method does not exist then I18n translate is called for the following key:
  # activerecord.defaults.my_model.value
  def value_default
    "This default is used when value is nil"
  end
end
```

### Example

```ruby
MyModel.new.value_default 
=> "This default is used when value is nil"

MyModel.new.value_effective 
=> "This default is used when value is nil"

my_model = MyModel.new
my_model.value = "My value"
my_model.value_effective
=> "My value"
```

### Sample locale 

```yaml
en:
  activerecord:
    defaults:
      my_model:
        value: A default value from I18n when model attribute does not exist
```

### Example - Common I18n named attributes

If your default locale strings frequently refer to similar or common named parameters then these can be shared with the I18n translation lookups by creating an instance method 'attr_effective_default_opts'


```ruby
class MyModel
  attr_accessible :value
  attr_effective :value

  def attr_effective_default_opts
    {
      company_name: "Acme"
    }
  end
end
```

```yaml
en:
  activerecord:
    defaults:
      my_model:
        value: Your company name is %{company_name}
```

```ruby
MyModel.new.value_default
=> "Your company name is Acme" 
```

## Dependencies

- activesupport (ActiveSupport::Concern)
- rails_i18n

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/attr_effective. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

