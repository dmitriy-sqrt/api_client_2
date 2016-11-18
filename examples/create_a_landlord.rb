require './client.rb'

#get branch info (assuming we have 'id' from elsewhere)
#branch_id = 363
#branches  = ApiClient::Branch.retreive_by_id(branch_id).data

#now try to create a landlord

landlord_data = {
  first_name: "Ivan34",
  last_name: "test",
  landlord_type: "individual",
  email: "tester@landlordmail.com"
}

new_landlord = ApiClient::Landlord.create(landlord_data, branches: 363)

if new_landlord.errors.any?
  puts "Landlord not created. "\
       "Errors: #{new_landlord.errors.map{ |e| e['detail'] } }"
else
  puts 'Created ok'
end
