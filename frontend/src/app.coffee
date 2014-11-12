window.App = Ember.Application.create()

App.ApplicationAdapter = DS.RESTAdapter.extend
  host: 'http://localhost:4000'
  namespace: 'api'

require './models/patient'

App.Router.map ->
  @resource 'patients'

App.IndexRoute = Ember.Route.extend
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
