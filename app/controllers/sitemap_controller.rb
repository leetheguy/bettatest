class SitemapController < ApplicationController
  def show
    @beta_tests = BetaTest.where(:active => true)
    render :layout => false
  end
end
