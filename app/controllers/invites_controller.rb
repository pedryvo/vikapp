class InvitesController < ApplicationController
  before_action :set_invite, only: %i[ show edit update destroy deactivate ]

  def index
    @invites = Invite.all
  end

  def show
  end

  def new
    @invite = Invite.new
  end

  def edit
  end

  def create
    @invite = Invite.new(invite_params)

    respond_to do |format|
      if @invite.save
        format.html { redirect_to @invite, notice: "Invite was successfully created." }
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invite.update(invite_params)
        format.html { redirect_to @invite, notice: "Invite was successfully updated." }
        format.json { render :show, status: :ok, location: @invite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invite.destroy!

    respond_to do |format|
      format.html { redirect_to invites_path, status: :see_other, notice: "Invite was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def deactivate
    if @invite.deactivated_at.nil?
      @invite.update(deactivated_at: Time.current)

      respond_to do |format|
        format.html { redirect_to invites_path, notice: "Invite was successfully deactivated." }
        format.json { render :show, status: :ok, location: @invite }
      end
    else
      respond_to do |format|
        format.html { redirect_to invites_path, notice: "Invite was already deactivated." }
        format.json { render :show, status: :ok, location: @invite }
      end
    end
  end

  private
    def set_invite
      @invite = Invite.find(params.expect(:id))
    end

    def invite_params
      params.expect(invite: [ :admin_id, :company_id ])
    end
end
