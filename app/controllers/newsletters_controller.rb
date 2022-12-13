class NewslettersController < ApplicationController
  def create
    @newsletter = Newsletter.new
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
