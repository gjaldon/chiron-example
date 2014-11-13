App.PatientsEditController = Ember.ObjectController.extend
  actions:
    submitForm: ->
      patient = @get('model')
      patient.save()
      @transitionToRoute 'patients'
