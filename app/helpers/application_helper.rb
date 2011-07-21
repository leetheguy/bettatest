module ApplicationHelper
  include Acl9Helpers
  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Redcarpet.new(text, *options).to_html.html_safe
  end

  def developer
    current_user && (current_user.has_role?(:developer, current_beta_test) || current_user.has_role?(:admin))
  end
end
