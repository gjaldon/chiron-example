App.PatientsRoute = Ember.Route.extend
  model: ->
    @store.find('patient')
