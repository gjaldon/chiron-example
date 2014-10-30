App = window
page = require 'page'

# TODO: store this in an Env var https://github.com/outaTiME/gulp-replace-task
App.api_host = "http://localhost:4000/api"
App.Helpers = require './utils/helpers'

# App-specific libraries
Home = require './components/home'
Patients = require './components/patients'
PatientForm = require './components/patient_form'
Modal = require './directives/modal'
InputValidate = require './directives/input_validate'

app = new Vue
  el: "#app"
  data:
    currentView: 'home'
    patientForm: false

# Routing
page '/', (context) -> app.currentView = 'home'
page '/patients', (context) -> app.currentView = 'patients'
page '/patients/new', (context) ->
  app.currentView = 'patients'
  currentView = app.$.currentView
  patientForm = currentView.$.patientForm
  patientForm.patientId = null
  patientForm.patient = {}
  app.patientForm = true
page '/patients/edit/:id', (context) ->
  app.currentView = 'patients'
  app.patientForm = true
  currentView = app.$.currentView
  patientForm = currentView.$.patientForm
  patientForm.patientId = context.params.id
  currentView.patients.every (patient) ->
    if patient._id == patientForm.patientId
      patientForm.patient = patient
      false
    else
      true
page.start()
