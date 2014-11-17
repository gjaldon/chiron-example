`import Ember from 'ember'`

PatientsNewRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'patients/new',
      into: 'patients/index'
      outlet: 'modal'

`export default PatientsNewRoute`
