`import Ember from 'ember'`

PatientsEditController = Ember.ObjectController.extend
  actions:
    submitForm: ->
      patient = @get('model')
      patient.save()
      @transitionToRoute 'patients'

    closeModal: ->
      @transitionToRoute 'patients'

`export default PatientsEditController`
