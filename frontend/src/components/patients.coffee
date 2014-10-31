module.exports =
  Vue.component 'patients',
    template: Helpers.template 'patients/index'
    data:
      patients: Helpers.get_data("patients")
    methods:
      anyPatients: ->
        @patients.length

      deletePatient: (tr, id, rev) ->
        event.preventDefault()
        patient = tr.$data
        response = Helpers.sync_delete("patients/#{id}", rev)
        if JSON.parse(response).ok
          position = @patients.indexOf(patient)
          if ~position then @patients.splice(position, 1)

