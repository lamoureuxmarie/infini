class NewslettersController < ApplicationController
  def create
    @newsletter = Newsletter.create(newsletter_params)
    if @newsletter.save
      redirect_to root_path, notice: 'Thank you! You subscribed successfully'
    else
      redirect_to root_path, notice: 'Please enter a valid email'
    end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:name, :email)
  end
end
