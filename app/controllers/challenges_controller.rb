class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: %i[show edit update destroy]

  # GET /challenges or /challenges.json
  def index
    @challenges = current_user.challenges
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
    # @challenge = current_user.challenges.build(challenge_params)

    system_prompt = "
      You are a master of Trivia and Enigma.
      Your task is to create a challenge in the form of an Enigma.
      Each challenge must include a title, the content of the challenge, and the secret answer.
      If specific instructions are provided, follow them precisely while crafting the challenge.
      Ensure the challenges are engaging, clear, and appropriately framed.
      Avoid introducing unnecessary information or deviating from the task.
      "
    llm = RubyLLM.chat.with_temperature(1).with_instructions(system_prompt).with_schema(ChallengeSchema)
    reponse = llm.ask("Generate")
    # for Michael ("Generate based on #{params[:subject]}")

    @challenge = Challenge.new(reponse.content)
    @challenge.user = current_user
    respond_to do |format|
      if @challenge.save
        format.html { redirect_to challenges_path, notice: 'Enigma was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_content }
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
    params.require(:challenge).permit(:title, :description)
  end
end
