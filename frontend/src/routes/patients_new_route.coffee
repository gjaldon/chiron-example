App.PatientsNewRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'patients/new',
      into: 'patients'
      outlet: 'modal'
