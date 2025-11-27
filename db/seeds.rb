# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# --- User ---
user = User.new({ 'id' => 1, 'email' => 'user@example.com', 'reset_password_token' => nil, 'reset_password_sent_at' => nil,
                  'remember_created_at' => nil })
user.password = 'password'
user.save

# --- Challenge ---
Challenge.create!({ 'id' => 1, 'title' => 'The Riddle of the Sphinx',
                    'description' => "In Greek mythology, a Sphinx (a monster with the head of a woman, the body of a lion, and the wings of a bird) guarded the entrance to the city of Thebes. She would pose a specific riddle to travelers, strangling and devouring anyone who could not answer.\n\n\"What goes on four legs in the morning, two legs at noon, and three legs in the evening?\"", 'user_id' => 1 })
Challenge.create!({ 'id' => 2, 'title' => 'The Enigma Machine',
                    'description' => 'During World War II, the Nazis used an electro-mechanical device called the Enigma machine to encrypt military communications. It used a series of rotating wheels (rotors) and a plugboard to scramble letters. The settings were changed daily, creating 159 million million million possible settings, leading the Germans to believe it was unbreakable.', 'user_id' => 1 })
Challenge.create!({ 'id' => 3, 'title' => 'The Gordian Knot',
                    'description' => 'In 333 BC, Alexander the Great arrived in the Phrygian capital of Gordium. There, an ox-cart was tied to a post with an intricate knot of cornel bark. An ancient prophecy stated that whoever could untie the knot would become the ruler of all Asia. The knot had no visible ends, making it impossible to unravel by normal means.', 'user_id' => 1 })
Challenge.create!({ 'id' => 4, 'title' => 'The Zodiac 340 Cipher',
                    'description' => 'The Zodiac Killer, a serial murderer who terrorized Northern California in the late 1960s, sent taunting letters to the press. One of them, sent in November 1969, contained a grid of 340 mysterious symbols. For 51 years, the "340 Cipher" baffled the FBI, NSA, and amateur codebreakers.', 'user_id' => 1 })
Challenge.create!({ 'id' => 5, 'title' => 'The Rosetta Stone',
                    'description' => "For centuries, the meaning of Ancient Egyptian hieroglyphs was completely lost to history; they were viewed merely as magical picture-symbols. In 1799, soldiers in Napoleon's army discovered a granodiorite stele in Rashid (Rosetta), Egypt, inscribed with three versions of a decree.", 'user_id' => 1 })

# --- Chat ---
Chat.create!({ 'id' => 1, 'user_id' => 1, 'challenge_id' => 1 })
Chat.create!({ 'id' => 2, 'user_id' => 1, 'challenge_id' => 2 })
Chat.create!({ 'id' => 3, 'user_id' => 1, 'challenge_id' => 3 })
Chat.create!({ 'id' => 4, 'user_id' => 1, 'challenge_id' => 4 })
Chat.create!({ 'id' => 5, 'user_id' => 1, 'challenge_id' => 5 })
