class Admin::TournamentsController < ApplicationController
  before_action :set_tournament, only: [:edit, :update, :destroy]

  # GET /admin/tournaments
  # GET /admin/tournaments.json
  def index
    @tournaments = Tournament.all
  end

  # GET /admin/tournaments/1
  # GET /admin/tournaments/1.json
  def show
  end

  # GET /admin/tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /admin/tournaments/1/edit
  def edit
  end

  # POST /admin/tournaments
  # POST /admin/tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)
    assign_tournament_teams

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to [:edit_admin, @tournament], notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: [:edit_admin, @tournament] }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tournaments/1
  # PATCH/PUT /admin/tournaments/1.json
  def update
    respond_to do |format|
      @tournament.assign_attributes(tournament_params)
      assign_tournament_teams

      if @tournament.save
        format.html { redirect_to [:edit_admin, @tournament], notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: [:edit_admin, @tournament] }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tournaments/1
  # DELETE /admin/tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to admin_tournaments_url, notice: 'Tournament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tournament_params
    params.require(:tournament).permit(:title)
  end

  def assign_tournament_teams
    @tournament.teams = Team.where(id: params.require(:tournament).fetch(:team_ids))
  end
end
