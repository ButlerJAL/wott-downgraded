RubyLLM.configure do |config|
  config.openai_api_key = ENV['OPENAI_API_KEY'] || Rails.application.credentials[:openai_api_key]
  config.openai_api_base = "https://models.inference.ai.azure.com"
  # config.default_model = "gpt-4.1-nano"

  # Use the new association-based acts_as API (recommended)
  config.use_new_acts_as = true
end
