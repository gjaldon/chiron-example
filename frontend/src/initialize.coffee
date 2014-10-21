App     = window
Vue     = require 'vue'
page    = require 'page'

App.Helpers =
  template: (name) ->
    request = new XMLHttpRequest()
    request.open('GET', "/templates/#{name}.html", false)
    request.send(null)
    request.responseText

# App-specific libraries

Home = require './components/home'
Test = require './components/test'

app = new Vue
  el: "#app"
  data:
    currentView: 'home'

# Routing
page '/', (context) -> app.currentView = 'home'
page '/test', (context) -> app.currentView = 'test'
page.start()
