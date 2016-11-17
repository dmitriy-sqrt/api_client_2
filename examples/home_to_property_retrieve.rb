require './client.rb'

#get all branches, that you have access to
branches = ApiClient::Branch.list_by_url('/api/branches').data

#pick first branch
branch = branches.first
branch_link = branch.data_links['self']

#and retrieve its data
branch_detailed = ApiClient::Branch.retreive_by_url(branch_link).data
branch_landlords_link = branch_detailed.data_links['landlords']

#now get branch landlords list
landlords = ApiClient::Landlord.list_by_url(branch_landlords_link).data

#and retrieve details for the last one
landlord_link = landlords.first.data_links['self']
landlord_detailed = ApiClient::Landlord.retreive_by_url(landlord_link).data

#go get his properties
landlord_properties_link = landlord_detailed.data_links['properties']
properties = ApiClient::Landlord.list_by_url(landlord_properties_link).data

#check if we`ve got the one from Franzburgh
target_property = properties.detect do
  |property| property.town == "London"
end

if target_property.present?
  puts "Franzburgh property found link: #{target_property.data_links['self']}"
else
  puts 'Nope, Franzburgh property not found'
end
