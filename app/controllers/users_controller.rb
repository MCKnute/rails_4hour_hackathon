class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  before_action :my_status, only: [:index, :borrower, :lender]

  # GET /users
  # GET /users.json
  def index
    if current_user.account_type == 1
      @my_status = 'Lender'
    else
      @my_status = 'Borrower'
    end

    if @my_status == 'Lender'
      @users = User.where(account_type: 2)
    else
      @users = User.where(account_type: 1)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  #def edit
  #end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save && @user.account_type == 1
        session[:user_id] = @user.id
        format.html { redirect_to lender_path, success: 'Lender was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      elsif @user.save && @user.account_type == 2
        session[:user_id] = @user.id
        format.html { redirect_to borrower_path, success: 'Borrower was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to new_user_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to new_user_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to new_user_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  #def destroy
  #  @user.destroy
  #  respond_to do |format|
  #    format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def my_status
      if account_type = 1
        @status_label = "Lender"
      elsif account_type = 2
        @status_label = "Borrower"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :borrow_reason, :borrow_description, :money, :account_type)
    end
end
