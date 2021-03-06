class Api::V1::StoresController < ApiController
  before_action :find_county, only: [:index]
  before_action :find_town, only: [:index]
  before_action :find_road, only: [:index]

  def index
    @stores = @road.stores

    render json: @stores, only: [:id, :store_code, :name, :address, :phone]
  end
end