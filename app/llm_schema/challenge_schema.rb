class ChallengeSchema < RubyLLM::Schema
  string :title
  string :description, description:"Your task is to create an Enigma"
end

# schema = ChallengeSchema.new
# puts schema.to_json
