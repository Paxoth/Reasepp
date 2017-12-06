=begin rdoc
 _**Errores:** controlador de los errores._
=end
class ErrorsController < ApplicationController
  #Método del error 404: página no encontrada
  def error404
    render status: :not_found
  end
end