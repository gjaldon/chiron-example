App = window
page = require 'page'

# TODO: store this in an Env var https://github.com/outaTiME/gulp-replace-task
App.api_host = "http://localhost:4000/api"

App.Helpers =
  template: (name) ->
    @sync_get "/templates/#{name}.html"

  get_data: (url) ->
    JSON.parse(@sync_get url).rows.map (object) ->
      object.value

  sync_get: (url) ->
    request = new XMLHttpRequest()
    request.open('GET', url, false)
    request.send(null)
    request.responseText

# App-specific libraries
Home = require './components/home'
Patients = require './components/patients'
Modal = require './directives/modal'

app = new Vue
  el: "#app"
  data:
    currentView: 'home'
    createPatientForm: false
  methods:
    hideModal: (e) ->
      @createPatientForm = false

# Routing
page '/', (context) -> app.currentView = 'home'
page '/patients', (context) -> app.currentView = 'patients'
page '/patients/new', (context) ->
  app.currentView = 'patients'
  app.createPatientForm = true
page.start()
