class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ show edit update destroy ]

  # GET /quests or /quests.json
  def index
    @quests = Quest.all.order(created_at: :asc)
    @new_quest = Quest.new
  end

  # GET /quests/1 or /quests/1.json
  def show
  end

  # GET /quests/new
  def new
    @quest = Quest.new
  end

  # GET /quests/1/edit
  def edit
  end

  # POST /quests or /quests.json
  def create
    @quest = Quest.new(quest_params)
    @new_quest = Quest.new
    @quests = Quest.all.order(created_at: :desc)

    respond_to do |format|
      if @quest.save
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.update("quests", partial: "quests/quests_list", locals: { quests: @quests }),
            turbo_stream.update("new_quest", partial: "form", locals: { quest: @new_quest })
          ]
        }
        format.html { redirect_to quests_path }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("new_quest",
            partial: "form",
            locals: { quest: @quest }
          )
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quests/1 or /quests/1.json
  def update
    respond_to do |format|
      if @quest.update(quest_params)
        format.html { redirect_to @quest, notice: "Quest was successfully updated." }
        format.json { render :show, status: :ok, location: @quest }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@quest, partial: "quests/quest", locals: { quest: @quest }) }
      end
    end
  end

  # DELETE /quests/1 or /quests/1.json
  def destroy
    @quest.destroy!
    @quests = Quest.all.order(created_at: :desc)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.update("quests",
          partial: "quests/quests_list",
          locals: { quests: @quests }
        )
      }
      format.html { redirect_to quests_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quest
      @quest = Quest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quest_params
      params.require(:quest).permit(:name, :status)
    end
end
