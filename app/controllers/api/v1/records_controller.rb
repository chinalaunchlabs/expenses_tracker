class Api::V1::RecordsController < ApplicationController
  before_action :authorize_user!
  before_action :get_record, only: [:update, :show, :destroy]

  def index
    page = params[:page] || 0
    @records = current_user.records.page(page)

    render 'api/v1/records/index'
  end

  def create
    @record = current_user.records.create(create_params)

    render 'api/v1/records/record'
  end

  def update
    @record.update_attributes(create_params)

    render 'api/v1/records/record'    
  end

  def show
    render 'api/v1/records/record'
  end

  def destroy
    @record.destroy!

    render json: { message: 'Record successfully deleted.' }, status: :ok
  end

  private
    def create_params
      params.require(:record).permit(:category_id, :notes, :amount, :record_type, :date)
    end

    def get_record
      @record = current_user.records.find(params[:id])
    end
end
