# == NullifyBlanks
#
# This plugin makes ActiveRecord write blank strings as null to
# nullable columns in the database rather than zero length strings.
#
# Just drop the plugin into your plugins folder and that’s all there
# is to it. There’s a rake task to nullify zero length strings in
# existing records if required.
#
# Copyright (c) 2009 Andrew White, released under the MIT license

module NullifyBlanks
  def self.included(base) #:nodoc:
    base.class_eval do

      def write_attribute_with_nullify(attr_name, value) #:nodoc:
        write_attribute_without_nullify(attr_name, nullify?(attr_name, value) ? nil : value)
      end

      alias_method_chain :write_attribute, :nullify

      private

        def nullify?(attr_name, value) #:nodoc:
          value.blank? && ((column = column_for_attribute(attr_name)) && column.text? && column.null)
        end

    end
  end
end

ActiveRecord::Base.send :include, NullifyBlanks