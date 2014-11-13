App.PatientsNewController = Ember.ObjectController.extend
  actions:
    createPatient: ->
      name = @get('newName')
      birthdate = @get('newBirthDate')
      mainContact = @get('newMainContact')
      mobileNo = @get('newMobileNo')
      landline = @get('newLandline')
      email = @get('newEmail')
      homeAddress = @get('newHomeAddress')
      gender = @get('newGender')

      patient = @store.createRecord 'patient',
        name: name
        main_contact: mainContact
        mobile_no: mobileNo
        landline : landline
        email: email
        home_address: homeAddress
        gender: gender

      patient.save()
      @transitionToRoute 'patients'
