module NullifyBlanks
  def self.included(base)
    base.class_eval do

      def write_attribute_with_nullify(attr_name, value)
        write_attribute_without_nullify(attr_name, nullify?(attr_name, value) ? nil : value)
      end

      alias_method_chain :write_attribute, :nullify

      private

        def nullify?(attr_name, value)
          value.blank? && ((column = column_for_attribute(attr_name)) && column.text? && column.null)
        end

    end
  end
end

ActiveRecord::Base.send :include, NullifyBlanks