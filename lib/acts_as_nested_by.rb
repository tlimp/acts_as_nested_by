module ActsAsNestedBy #:nodoc:
  def self.included(base) #:nodoc:
    base.send :extend, ClassMethods
  end

  module ClassMethods
    # Generates instance methods for setting and getting a 'nested_by_other' flag for each ':other' in association_names
    # * Example:
    #     Bar < ActiveRecord::Base
    #       belongs_to :other
    #       acts_as_nested_by :other
    #     end
    #
    #   generates methods
    #     Bar#nested_by_other=
    #     Bar#nested_by_other
    #     Bar#nested_by_other?
    # * Exceptions raised
    #   * ArgumentError if one of the associations does not exist
    #   * ArgumentError if one of the associations is not created by the :belongs_to macro
    def acts_as_nested_by(*association_names)
      association_names.each do |association_name|
        if reflection = reflect_on_association(association_name)
          if :belongs_to == reflection.macro
            class_eval %{
              def nested_by_#{association_name}=(nested_by_#{association_name})
                @nested_by_#{association_name} = nested_by_#{association_name}
              end

              def nested_by_#{association_name}
                @nested_by_#{association_name} = !@nested_by_#{association_name} ? false : true
              end

              def nested_by_#{association_name}?
                nested_by_#{association_name}
              end
            }
          else
            raise ArgumentError, "Association `#{association_name}' must be :belongs_to but it's `#{reflection.macro}'."
          end
        else
          raise ArgumentError, "No association found for name `#{association_name}'. Has it been defined yet?"
        end
      end
    end
  end
end
require "active_record"
ActiveRecord::Base.send :include, ActsAsNestedBy