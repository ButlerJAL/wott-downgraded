class ChatsController < ApplicationController
  before_action :set_challenge

  def show
    @chat = current_user.chats.find_or_create_by(challenge: @challenge)
    @chat.with_instructions <<~TEXT
      You are a passive agressive tutor specialized on the enigma titled: '#{@challenge.title}'.
      #{@challenge.description}
      I enjoy playing and solving enigmas.
      Guide me to find the answer myself without giving the answer directly.
      You strictly only know about the enigma titled: '#{@challenge.title}'.
      Your response should have about 20 words.
      Your response should have an attitude based on your temper that is '#{@challenge.temper}'.

    TEXT
    @message = Message.new
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end
end
