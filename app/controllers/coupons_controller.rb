class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_store!

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all
    set_shop_show
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    set_shop_show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
    set_shop_show
  end

  # GET /coupons/1/edit
  def edit
    set_shop_show
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html {redirect_to @coupon, notice: 'Coupon was successfully created.'}
        format.json {render :show, status: :created, location: @coupon}
      else
        format.html {render :new}
        format.json {render json: @coupon.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html {redirect_to @coupon, notice: 'Coupon was successfully updated.'}
        format.json {render :show, status: :ok, location: @coupon}
      else
        format.html {render :edit}
        format.json {render json: @coupon.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html {redirect_to coupons_url, notice: 'Coupon was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def generate
    set_shop_show
  end

  def create_coupons
    i = 0
    num = params[:number].to_i
    @store = Store.find(current_store.id)
    while i < num do
      @store.coupon.create(coupon_params.merge(code:randy))
      i += 1
    end
    redirect_to(coupons_path)
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:code, :number_of_use, :percentage, :expiry)
    end

    def randy
      ref = [*'A'..'Z', *"0".."9"].sample(4).join
    end
  end
