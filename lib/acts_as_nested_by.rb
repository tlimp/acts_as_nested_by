module ActsAsNestedBy#:nodoc
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods #:nodoc
    # Generates instance methods for setting and reading a nested_by_other flag
    # raises ArgumentError if association to other does not exist or is not created by the :belongs_to macro
    def acts_as_nested_by(*association_names)
      association_names.each do |association_name|
        if reflection = reflect_on_association(association_name)
          if :belongs_to == reflection.macro
            class_eval %{
            
              def nested_by_#{association_name}=(nested_by_#{association_name})
                @nested_by_#{association_name} = nested_by_#{association_name}
              end
            
              def nested_by_#{association_name}
                @nested_by_#{association_name} = @nested_by_#{association_name}.nil? ? false : true
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