  class Users::RegistrationsController < Devise::RegistrationsController # :nodoc:
  # before_filter :configure_sign_up_params, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]
    before_filter :configure_permitted_parameters
    before_action :estatuto

    add_breadcrumb "Inicio", :root_path
    add_breadcrumb "Datos de usuario"

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:name, :nickname, :category, :autorization_level,:is_admin)
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:institution_id,:nickname, :name, :description,:photo, :email, :password, :password_confirmation, :current_password,:is_admin) }
    end
    
    private
    
    def estatuto
      @sections = Section.all
      @institutions = Institution.all
    end

  end
