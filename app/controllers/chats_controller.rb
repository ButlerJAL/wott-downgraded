class ChatsController < ApplicationController
  before_action :set_challenge

  def show
    @chat = current_user.chats.find_or_create_by(challenge: @challenge)
    context = "I am working on a challenge titled '#{@challenge.title}'. #{@challenge.description} Your answers will be in english language.
    your answers should be done with a passive aggressive attitude. if the first answer is false give one clue. if the second answer is false give one more clue.
    the clues will be max 1 line. After 2 false answers you give a choice of 3 answers."
    # chat.with_instructions()
    @chat.messages.create(role: 'system', content: context)
    @message = Message.new
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end
end
