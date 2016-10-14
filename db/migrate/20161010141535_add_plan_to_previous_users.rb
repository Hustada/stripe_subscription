class AddPlanToPreviousUsers < ActiveRecord::Migration
  def up 
  	User.all.each do |user|
  		user.create_plan
  	end
  end
end
