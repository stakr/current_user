module Stakr #:nodoc:
  module CurrentAuthor #:nodoc:
    
    # TODO
    module Model
      
      def self.included(base) #:nodoc:
        base.alias_method_chain :touch,  :current_author
        base.alias_method_chain :create, :current_author
        base.alias_method_chain :update, :current_author
        
        base.class_inheritable_accessor :record_current_author, :instance_writer => false
        base.record_current_author = true
      end
      
      private
        
        def touch_with_current_author(attribute = nil) #:nodoc:
          if attribute
            send("#{attribute}=", Author.current) if Author.current
          else
            self.updator = Author.current if respond_to?(:updator) && Author.current
          end
          touch_without_current_author(attribute)
        end
        
        def create_with_current_author #:nodoc:
          if record_current_author
            self.creator = Author.current if respond_to?(:creator) && creator.nil? && Author.current
            self.updator = Author.current if respond_to?(:updator) && updator.nil? && Author.current
          end
          create_without_current_author
        end
        
        def update_with_current_author(*args) #:nodoc:
          if record_current_author && (!partial_updates? || changed?)
            self.updator = Author.current if respond_to?(:updator) && Author.current
          end
          update_without_current_author(*args)
        end
        
    end
    
  end
end
