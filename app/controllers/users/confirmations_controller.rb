class Users::ConfirmationsController < Devise::ConfirmationsController # :nodoc:
  before_action :estatuto

  private
  
  def estatuto
    @sections = Section.all
    @institutions = Institution.all
  end
end
