class NewslettersController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @newsletter = Newsletter.create(newsletter_params)
    if @newsletter.save
      redirect_to root_path
    else
      render :new, notice: "Oops. Something went wrong..."
    end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:name, :email)
  end
end
