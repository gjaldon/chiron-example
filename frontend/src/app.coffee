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

App.ApplicationSerializer = DS.RESTSerializer.extend
  primaryKey: '_id'

require './models/patient'
require './controllers/patient_controller'
require './controllers/patients_new_controller'
require './controllers/patients_controller'
require './routes/patients_route'
require './routes/patients_new_route'

App.Router.map ->
  @resource 'patients', ->
    @route 'new'

# # Routing
# page '/', (context) -> app.currentView = 'home'
# page '/patients/edit/:id', (context) ->
#   app.currentView = 'patients'
#   app.patientForm = true
#   currentView = app.$.currentView
#   patientForm = currentView.$.patientForm
#   patientForm.patientId = context.params.id
#   currentView.patients.every (patient) ->
#     if patient._id == patientForm.patientId
#       patientForm.patient = patient
#       false
#     else
#       true
# page.start()
