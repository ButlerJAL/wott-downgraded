class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: %i[show edit update destroy]

  # GET /challenges or /challenges.json
  def index
    @challenges = current_user.challenges
    if @challenges.count == 0
      redirect_to new_challenge_path
    end
  end

  # GET /challenges/1
  def show
    redirect_to challenge_chat_path(@challenge)
  end

  # GET /challenges/new
  def new
    @challenge = current_user.challenges.build
  end

  # GET /challenges/1/edit
  def edit
  end

  def create_with_ai
    system_prompt = "
      You are a the game master for our Enigma game.
      Your task is to create an Enigma for a user to guess.
      Each Enigma must include a title and the description should include the content of the Enigma with a category of #{params[:category]} and difficulty of #{params[:difficulty]}.
      The title should not contain the answer.
      If specific instructions are provided, follow them precisely while crafting the Enigma.
      Ensure the Enigma is clear and appropriately framed.
      Avoid introducing unnecessary information or deviating from the task.
      "

    llm = RubyLLM.chat.with_temperature(1).with_instructions(system_prompt).with_schema(ChallengeSchema)
    response = llm.ask("Generate an enigma challenge")

    # Debug: Check what type response.content is
    # Rails.logger.info "Response class: #{response.content.class}"
    # Rails.logger.info "Response content: #{response.content.inspect}"

    respond_to do |format|
      format.json do
        render json: {
          title: response.content["title"],
          description: response.content["description"]
        }
        end
      end
  end


  # POST /challenges
  def create
    @challenge = current_user.challenges.build(challenge_params)
    respond_to do |format|
      if @challenge.save
        format.html { redirect_to challenges_path, notice: 'Enigma was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /challenges/1
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to challenges_path, notice: 'Enigma was successfully updated.', status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  # DELETE /challenges/1
  def destroy
    @challenge.destroy!

    respond_to do |format|
      format.html { redirect_to challenges_path, notice: 'Enigma was successfully destroyed.', status: :see_other }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = current_user.challenges.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def challenge_params
    params.require(:challenge).permit(:title, :description, :category, :temper, :difficulty)
  end
end
