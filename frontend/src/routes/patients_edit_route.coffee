App.PatientsEditRoute = Ember.Route.extend
  model: ->
    @store.find('patient', params.patient_id)

  renderTemplate: ->
    @render 'patients/edit',
      into: 'patients'
      outlet: 'modal'
