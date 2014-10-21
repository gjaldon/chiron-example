App     = window
page    = require 'page'

App.Helpers =
  template: (name) ->
    request = new XMLHttpRequest()
    request.open('GET', "/templates/#{name}.html", false)
    request.send(null)
    request.responseText

# App-specific libraries

Home = require './components/home'
Patients = require './components/patients'

app = new Vue
  el: "#app"
  data:
    currentView: 'home'

# Routing
page '/', (context) -> app.currentView = 'home'
page '/patients', (context) -> app.currentView = 'patients'
page.start()
