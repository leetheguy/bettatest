module ApplicationHelper
  include Acl9Helpers
  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Redcarpet.new(text, *options).to_html.html_safe
  end

  def shorten(text)
    if text.length > 200
      text+'...'
    else
      text
    end
  end

  def developer
    current_user && current_user.has_role?(:developer, current_beta_test)
  end

  def tester
    current_user && current_user.has_role?(:tester, current_beta_test)
  end

  def admin
    current_user && current_user.has_role?(:admin)
  end

  def proper_url(url)
    url =~ /http:\/\// ? url : 'http://'+url
  end
end
