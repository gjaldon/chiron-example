App.PatientController = Ember.ObjectController.extend
  actions:
    deletePatient: ->
      patient = @get('model')
      patient.destroyRecord()
