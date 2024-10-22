class ApplicationController < ActionController::API
  respond_to :json
  before_action :set_default_request_format, :authenticate_user!
  rescue_from Exception do |exception|
    if exception.instance_of?(ActiveRecord::RecordNotFound)
      record_not_found
    elsif exception.instance_of?(ActionController::BadRequest)
      bad_request
    elsif exception.instance_of?(ActiveRecord::RecordInvalid)
      record_invalid
    elsif exception.instance_of?(CanCan::AccessDenied)
      access_denied
    elsif exception.instance_of?(ActiveRecord::RecordNotUnique)
      record_not_unique
    elsif exception.instance_of?(PlanetFieldsFull)
      planet_fields_full
    elsif exception.instance_of?(NotEnoughResources)
      not_enough_resources
    elsif exception.instance_of?(MaxQueue)
      max_queue_length_reached
    elsif exception.instance_of?(NoBuildingInQueue)
      no_building_in_queue
    elsif exception.instance_of?(NoBuildingToDemolish)
      no_building_to_demolish
    elsif exception.instance_of?(CantDemolishBuildingInQueue)
      cant_demolish_building_in_queue
    elsif exception.instance_of?(CantBuildIfDemolitionInQueue)
      cant_build_if_demolition_in_queue
    elsif exception.instance_of?(NoFreePlanets)
      no_free_planets
    else
      internal_server_error
    end
  end

  def record_not_found
    render json: { error: 'not found' }, status: :not_found
  end

  def access_denied
    render json: { error: 'access denied' }, status: :unauthorized
  end

  def record_invalid
    render json: { error: 'record invalid' }, status: :unprocessable_entity
  end

  def record_not_unique
    render json: { error: 'record not unique' }, status: :conflict
  end

  def bad_request
    render json: { error: 'bad request' }, status: :bad_request
  end

  def planet_fields_full
    render json: { error: 'planet fields full' }, status: :bad_request
  end

  def not_enough_resources
    render json: { error: 'not enough resources' }, status: :bad_request
  end

  def max_queue_length_reached
    render json: { error: 'max queue length reached' }, status: :bad_request
  end

  def no_free_planets
    render json: { error: 'no free planets' }, status: :bad_request
  end

  def no_building_in_queue
    render json: { error: 'no building in queue' }, status: :bad_request
  end

  def no_building_to_demolish
    render json: { error: 'no building to demolish' }, status: :bad_request
  end

  def cant_demolish_building_in_queue
    render json: { error: 'You can not demolish building in queue' }, status: :bad_request
  end

  def cant_build_if_demolition_in_queue
    render json: { error: 'You can not build if demolition in queue' }, status: :bad_request
  end

  def internal_server_error
    render json: { error: 'internal server error' }, status: :internal_server_error
  end

  def set_default_request_format
    request.format = :json unless params[:format]
    headers['Access-Control-Allow-Headers'] = 'Authorization'
  end
end
