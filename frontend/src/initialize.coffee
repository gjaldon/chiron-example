App = window
page = require 'page'

# TODO: store this in an Env var https://github.com/outaTiME/gulp-replace-task
App.api_host = "http://localhost:4000/api"

App.Helpers =
  animationendEvents: [
    "webkitAnimationEnd"
    "animationend"
    "MSAnimationEnd"
    "oanimationend"
  ]

  template: (name) ->
    @sync_get "/templates/#{name}.html"

  get_data: (url) ->
    url = "#{api_host}/#{url}"
    JSON.parse(@sync_get url).rows?.map (object) ->
      object.value

  toQueryString: (obj) ->
    queryString = ""
    for key, value of obj
      if value then queryString += "#{key}=#{value}&"
    queryString[0..-2]

  sync_delete: (url, rev) ->
    request = new XMLHttpRequest()
    request.open("DELETE", "#{api_host}/#{url}?rev=#{rev}", false)
    request.send()
    request.responseText

  sync_post: (url, data) ->
    request = new XMLHttpRequest()
    params = @toQueryString(data)
    request.open("POST", "#{api_host}/#{url}", false)
    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    request.send(params)
    request.responseText

  sync_get: (url) ->
    request = new XMLHttpRequest()
    request.open('GET', url, false)
    request.send()
    request.responseText

  addAnimationEndEvent: (elem, handler) ->
    for event in @animationendEvents
      elem.addEventListener event, handler

  removeAnimationEndEvent: (elem, handler) ->
    for event in @animationendEvents
      elem.removeEventListener event, handler

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
