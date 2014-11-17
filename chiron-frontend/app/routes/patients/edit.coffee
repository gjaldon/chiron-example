`import Ember from 'ember'`

PatientsEditRoute = Ember.Route.extend
  model: ->
    @store.find('patient', params.patient_id)

  renderTemplate: ->
    @render 'patients/edit',
      into: 'patients/index'
      outlet: 'modal'

`export default PatientsEditRoute`
