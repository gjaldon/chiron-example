App.PatientsNewController = Ember.ObjectController.extend
  actions:
    submitForm: ->
      patient = @store.createRecord 'patient',
        name: @get('name')
        birthdate: @get('birthdate')
        main_contact: @get('main_contact')
        mobile_no: @get('mobile_no')
        landline : @get('landline')
        email: @get('email')
        home_address: @get('home_address')
        gender: @get('gender')

      patient.save()
      @transitionToRoute 'patients'
