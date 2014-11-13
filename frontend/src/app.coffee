window.App = Ember.Application.create()

set = Ember.set
get = Ember.get

App.ApplicationAdapter = DS.RESTAdapter.extend
  host: 'http://localhost:4000'
  namespace: 'api'
  deleteRecord: (store, type, record) ->
    id = get(record, 'id')
    rev = record._data._rev
    headers = {"If-Match": rev}

    set(@, 'headers', headers)
    @ajax(@buildURL(type.typeKey, id, record), "DELETE")
  updateRecord: (store, type, record) ->
    data = {}
    serializer = store.serializerFor(type.typeKey)

    serializer.serializeIntoHash(data, type, record, {includeId: true})
    id = get(record, 'id')
    data.patient._rev = record._data._rev
    @ajax(@buildURL(type.typeKey, id, record), "PUT", {data: data})

App.ApplicationSerializer = DS.RESTSerializer.extend
  primaryKey: '_id'

require './router'
require './models/patient'
require './controllers/patient_controller'
require './controllers/patients_new_controller'
require './controllers/patients_edit_controller'
require './controllers/patients_controller'
require './routes/patients_route'
require './routes/patients_new_route'
require './routes/patients_edit_route'
require './components/modal_dialog_component'
