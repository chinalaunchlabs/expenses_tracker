class Api::V1::RecordsController < ApplicationController
  before_action :authorize_user!
  before_action :get_record, only: [:update, :show, :destroy]

  def seed
    num = params[:num].to_i || 10

    current_user.seed(num)

    render json: { message: "Records seeded successfully!" }, status: :ok
  end

  def index
    page = params[:page] || 0
    @limit = params[:limit].to_i || nil
    @day = params[:day] || nil
    @category_ids = params[:category_ids] || nil
    @q = params[:q] || nil

    @records = current_user.records.order(date: :desc)
    
    if @day
      @records = @records.on_day(@day)
    end

    if @q
      @records = @records.where('LOWER(notes) LIKE ?', "%#{@q.downcase}%")
    end

    if @category_ids
      @records = @records.where(category_id: @category_ids)
    end

    puts @records.inspect
    puts "Limit: #{@limit}"

    if @limit > 0
      @records = @records.limit(@limit)
    else
      @records = @records.page(page).per(10)
    end

    puts @records.inspect
  
    render 'api/v1/records/index'
  end

  def overview
    duration = params[:duration] || "day"

    @income = current_user.records.income.sum(:amount)
    @expenses = current_user.records.expense.sum(:amount)

    # if duration == "day"

    # elsif duration == "week"

    # elsif duration == "month"

    # elsif duration == "year"

    # end

    render 'api/v1/records/overview'
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
