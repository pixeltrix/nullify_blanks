require 'test/unit'
require 'rubygems'
require 'active_record'
require 'active_record/fixtures'
require File.dirname(__FILE__) + '/../lib/nullify_blanks'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

def setup_db
  ActiveRecord::Migration.suppress_messages do
    ActiveRecord::Schema.define(:version => 1) do
      create_table :products do |t|
        t.string :name, :limit => 100, :null => false
        t.string :description, :limit => 255, :null => true
      end
    end
  end

  Fixtures.create_fixtures(File.dirname(__FILE__) + '/fixtures', ActiveRecord::Base.connection.tables)
end

def teardown_db
  ActiveRecord::Migration.suppress_messages do
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end

  Fixtures.reset_cache
end

class Product < ActiveRecord::Base
end

class NullifyBlanksTest < Test::Unit::TestCase

  def setup
    setup_db
  end

  def teardown
    teardown_db
  end

  def test_nullable_column_is_nullified_when_assigned_an_empty_string
    product = Product.find(1)
    assert !product.description.blank?
    product.update_attributes!(:description => "")
    product.reload
    assert product.description.nil?
  end

  def test_nullable_column_is_nullified_when_assigned_a_nil_value
    product = Product.find(1)
    assert !product.description.blank?
    product.update_attributes!(:description => nil)
    product.reload
    assert product.description.nil?
  end

  def test_nullable_column_is_not_nullified_when_assigned_a_non_empty_string
    product = Product.find(1)
    assert !product.description.blank?
    product.update_attributes!(:description => "Description")
    product.reload
    assert !product.description.nil?
  end

  def test_not_null_column_is_not_nullified_when_assigned_an_empty_string
    product = Product.find(1)
    assert !product.name.blank?
    product.update_attributes!(:name => "")
    product.reload
    assert !product.name.nil?
  end

  def test_not_null_column_is_not_nullified_when_assigned_a_non_empty_string
    product = Product.find(1)
    assert !product.name.blank?
    product.update_attributes!(:name => "Name")
    product.reload
    assert !product.name.nil?
  end

end