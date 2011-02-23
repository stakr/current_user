require 'active_record/current_user'

ActiveRecord::Base.class_eval do
  include ActiveRecord::CurrentUser
end
