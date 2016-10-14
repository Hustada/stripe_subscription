class UsersController < ApplicationController
	before_filter :authenticate_user!
  
  def info
  	@plan = current_user.plan
  	if @plan.active
  		@stripe_customer = Stripe::Customer.retrieve(@plan.stripe_user_id)
  		@stripe_plan = @stripe_customer.subscriptions.first
  	end
  end

  def cancel_plan
  	@stripe_customer = Stripe::Customer.retrieve(
  		current_user.plan.stripe_user_id
  	)
  	@stripe_plan = @stripe_customer.subscriptions.first
  	@stripe_plan.delete(at_period_end: false)
  	current_user.plan.active = false
  	current_user.plan.save
  	redirect_to users_info_path
  end

  def charge
  	token = params["stripeToken"]
  	customer = Stripe::Customer.create(
  		source: token,
  		plan: 'mysubscriptionlevel1',
  		email: current_user.email
  		)

  	current_user.plan.stripe_user_id =
  	customer.id
  	current_user.plan.active = true
  	current_user.plan.save

  	redirect_to users_info_path
  end

end

