=begin rdoc
  _**Contact:** controlador de la página de Contacto (Ver Contact)_

  _Este controlador fue creado en su mayoría automáticamente por scaffold_
=end
class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Contacto", :contacts_path

  #Vista principal de la página de contacto
  def index # :nodoc:
    @contact = Contact.new
  end

  #Generado automáticamente por scaffold, no utilizado
  def show # :nodoc:
    add_breadcrumb "Nuevo comentario", :contacts_path
  end

  #Generado automáticamente por scaffold, no utilizado
  def new# :nodoc:
    @contact = Contact.new
  end

  #Generado automáticamente por scaffold, no utilizado
  def edit # :nodoc:
  end 

  #Método crear contacto
  #Al generar el contacto se utiliada los mailer para poder enviar lo correos tanto a el usuario como a la página de REASE.
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        ContactMailer.contact_receiver(@contact).deliver
        ContactMailer.contact_sender(@contact).deliver
        format.html { redirect_to @contact, notice: 'Su mensaje ha sido enviado' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # Generado automáticamente por scaffold, no utilizado
  def update # :nodoc:
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: '' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # Generado automáticamente por scaffold, no utilizado
  def destroy # :nodoc:
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: '' }
      format.json { head :no_content }
    end
  end

  private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :body)
    end

end
