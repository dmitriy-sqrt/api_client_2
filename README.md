Helpthemove API Client (beta)
=============================

Base operations
------------------------------

`list_by_url(url)` - get items collection from specified link endpoint

`retreive_by_url(url)` - get single item data from specified link endpoint

`retreive_by_id(id)` - get single item data by its id

`create(data, parent)` - tries to create a new record with passed data

**Params:**

*url* - string url (e.g. http://localhost:3000/api/branches/31)

*id* - integer item id

*data* - attributes hash (e.g. 
```{
  first_name: "Ivan34",
  last_name: "test",
  landlord_type: "individual",
  email: "tester@landlordmail.com"
}```
)

*parent* - {key: value} reference to parent record (e.g. `branches: 363` when creating a landlord for branch with id=363)

Supported endpoints
------------------------------
Currently `Branch`, `Landlord` and `Property` endpoints are supported.

Custom endpoints can be added by inheriting `ApiClient::Base` class.

Usage
------------------------------
Just enter correct API settings and `require './client.rb'` or use any sample in `examples` directory.

Customizing ApiClient settings
------------------------------
  `API_HOST = '0.0.0.0'` - api host address
  
  `API_PORT = '3000'` - api host port
  
  `API_ID   = 'test'` - api key id
  
  `API_KEY  = 'test'` - api key secret
  
  `API_VERSION = '1'` - used api version
  
  `DEBUG_REQUESTS = false` - show sent requests in console
  
  `DEBUG_RESPONSES = false` - show responses received from api
  
