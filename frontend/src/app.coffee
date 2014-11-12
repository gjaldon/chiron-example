window.App = Ember.Application.create()

App.Router.map ->
  @resource 'patients'

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
