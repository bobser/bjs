class Job < ActiveRecord::Base
  attr_accessible :apply_link, :category, :employer_id, :job_description, :category, :location, :title, :date

  belongs_to :user
  
end
