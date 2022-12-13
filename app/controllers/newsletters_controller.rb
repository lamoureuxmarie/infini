class NewslettersController < ApplicationController
  def create
    @newsletter = Newsletter.create(newsletter_params)
    if @newsletter.save
      redirect_to root_path, notice: "Thank you! You subscribed successfully"
    else
      render :new, notice: "Oops. Something went wrong..."
    end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:name, :email)
  end
end
