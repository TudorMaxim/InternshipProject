class ChargesController < ApplicationController
  authorize_resource class: :charge

  def create
    # Amount in cents
    @skin = Skin.find_by(id: params[:skin_id])
    @amount = @skin.price.to_i * 100
    # Get the credit card details submitted by the form
    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
    )

    begin
      Stripe::Charge.create(
          :customer => customer.id,
          :amount => @amount,
          :currency => 'usd',
          :description => "#{customer.email} bought #{@skin.name}"
      )
      flash[:notice] = "#{@skin.name} succesfully bought"

      BoughtSkin.create(user_id: current_user.id,
                        name: @skin.name,
                        skin_type: @skin.skin_type,
                        selected: false,
                        image: @skin.image)

      redirect_to inventory_path

      rescue Stripe::CardError => e
      flash[:danger] = e.message
      redirect_to root_path
    end
  end
end
