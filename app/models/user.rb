class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :plan


  after_create :create_plan

  def create_plan
  	Plan.create(user_id: id) if plan.nil?
  end


end
