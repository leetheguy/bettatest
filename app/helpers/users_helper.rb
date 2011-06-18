module UsersHelper
  def page_belongs_to_current_user
    current_user.id == @user.id
  end
end
