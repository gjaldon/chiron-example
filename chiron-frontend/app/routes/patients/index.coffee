`import Ember from 'ember'`

PatientsIndexRoute = Ember.Route.extend
  model: ->
    @store.find('patient')

`export default PatientsIndexRoute`
