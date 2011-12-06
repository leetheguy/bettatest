module ApplicationHelper
  include Acl9Helpers
  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Redcarpet.new(text, *options).to_html.html_safe
  end

  def shorten(text, length = 200)
    if text.length > length
      text[0...length]+'...'
    else
      text
    end
  end

  def developer(beta_test = current_beta_test)
    current_user && current_user.has_role?(:developer, current_beta_test)
  end

  def tester(beta_test = current_beta_test)
    current_user && current_user.has_role?(:tester, beta_test)
  end

  def admin
    current_user && current_user.has_role?(:admin)
  end

  def proper_url(url)
    url =~ /http:\/\// ? url : 'http://'+url
  end

  def inside_beta_test
    if current_beta_test && ['beta_tests', 'blogs', 'forum_categories', 'forum_topics', 'forum_posts', 'surveys', 'survey_options', 'tickets', 'tester_stat_sheets'].index(current_controller)
      if current_controller == 'beta_tests' && current_action == 'index'
        false
      else
        true
      end
    else
      false
    end
  end
end
