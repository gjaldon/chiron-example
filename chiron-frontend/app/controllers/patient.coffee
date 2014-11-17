`import Ember from 'ember'`

PatientController = Ember.ObjectController.extend
  actions:
    deletePatient: ->
      patient = @get('model')
      patient.destroyRecord()

`export default PatientController`
