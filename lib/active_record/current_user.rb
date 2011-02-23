module ActiveRecord
  
  # TODO
  module CurrentUser
    
    def self.included(base) #:nodoc:
      base.alias_method_chain :touch,  :current_user
      base.alias_method_chain :create, :current_user
      base.alias_method_chain :update, :current_user
      
      base.class_inheritable_accessor :current_user_class_name, :instance_writer => false
      base.current_user_class_name = 'User'
    end
    
    private
      
      def touch_with_current_user(timestamp_attribute = nil, current_user_attribute = nil) #:nodoc:
        if current_user_class_name && (current = current_user_class_name.constantize.current)
          if current_user_attribute
            send("#{attribute}=", current)
          else
            self.updator = current if respond_to?(:updator)
          end
        end
        touch_without_current_user(timestamp_attribute)
      end
      
      def create_with_current_user #:nodoc:
        if current_user_class_name && (current = current_user_class_name.constantize.current)
          self.creator = current if respond_to?(:creator) && creator.nil?
          self.updator = current if respond_to?(:updator) && updator.nil?
        end
        create_without_current_user
      end
      
      def update_with_current_user(*args) #:nodoc:
        if current_user_class_name && (current = current_user_class_name.constantize.current) && (!partial_updates? || changed?)
          self.updator = current if respond_to?(:updator)
        end
        update_without_current_user(*args)
      end
      
  end
  
end
