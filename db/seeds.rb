# Add seed data in this file
#require 'rest-client'

puts "Seeding spells..."
# these are the spells we want to add to the database
spells = ["acid-arrow", "animal-messenger", "calm-emotions", "charm-person"]

# iterate over each spell
spells.each do |spell|
  # make a request to the endpoint for the individual spell:
  #response = RestClient.get "https://www.dnd5eapi.co/api/spells/#{spell}"
 
  url = "https://www.dnd5eapi.co/api/spells/#{spell}"
header = {
      :content_type => "application/json"
}
resource = RestClient::Resource.new(
  url,
  headers: header,
  verify_ssl: false
)

response = resource.get


  # the response will come back as a JSON-formatted string.
  # use JSON.parse to convert this string to a Ruby hash:
  spell_hash = JSON.parse(response)

  # create a spell in the database using the data from this hash:
  Spell.create(
    name: spell_hash["name"],
    level: spell_hash["level"],
    description: spell_hash["desc"][0] # spell_hash["desc"] returns an array, so we need to access the first index to get just a string of the description
  )
end

puts "Done seeding!"