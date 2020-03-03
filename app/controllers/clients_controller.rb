class ClientsController < ApplicationController
  include AppHelper
  before_action :authenticate_admin!, except: [:edit, :update, :show]
  before_action :authenticate_user!, only: [:edit, :update, :show]
  before_action :set_client, only: [:show, :edit, :update, :destroy, :custom_mail_queue, :unmatch_from]

  def custom_mail_queue
    @mail_queue = MailQueue.new
  end

  def unmatch_from
    @mail_image = MailImage.find(params[:mail_image_id])
    @client.client_keyword_matches.where(mail_image_id: @mail_image.id).destroy_all
    @mail_queue = @mail_image.mail_queue

    respond_to do |format|
      format.html{ redirect_to mail_queue_path(@mail_queue) }
    end
  end

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    # uncomplete
    # render
    # complete
  end


  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        password = params[:password] || random_password
        @client.user.update(password: password)

        ClientMailer.after_sign_up(@client, password).deliver_now
        format.html { redirect_to clients_path, notice: "Client: #{@client.email} was sucessfully created." }
        # format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        # format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if @client.update(client_params)
        @client.user.update(password: params[:password]) if params[:password] # spec spec
        format.html { redirect_to clients_path, notice: "Client: #{@client.email} was sucessfully updated." }
        # format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        # format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(
        :email, :email2, :email3, :keywords,
        :name, :company_name, :phone, :client_number
      )
    end
end
