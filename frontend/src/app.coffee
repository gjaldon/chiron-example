window.App = Ember.Application.create()

set = Ember.set
get = Ember.get

App.ApplicationAdapter = DS.RESTAdapter.extend
  host: 'http://localhost:4000'
  namespace: 'api'
  deleteRecord: (store, type, record) ->
    id = get(record, 'id')
    rev = record._data._rev
    headers = get(@, 'headers') || {}
    headers["If-Match"] = rev

    set(@, 'headers', headers)
    @ajax(@buildURL(type.typeKey, id, record), "DELETE")

App.ApplicationSerializer = DS.RESTSerializer.extend
  primaryKey: '_id'

require './models/patient'
require './controllers/patient_controller'

App.Router.map ->
  @resource 'patients'

App.PatientsRoute = Ember.Route.extend
  model: ->
    @store.find('patient')

# # Routing
# page '/', (context) -> app.currentView = 'home'
# page '/patients', (context) ->
#   app.currentView = 'patients'
#   app.patientForm = false
# page '/patients/new', (context) ->
#   app.currentView = 'patients'
#   currentView = app.$.currentView
#   patientForm = currentView.$.patientForm
#   patientForm.patientId = null
#   patientForm.patient = {}
#   app.patientForm = true
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
