require 'stakr/current_author/model'

::ActiveRecord::Base.class_eval do
  include ::Stakr::CurrentAuthor::Model
end
