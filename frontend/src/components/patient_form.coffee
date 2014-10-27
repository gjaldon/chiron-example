moment = require 'moment'

module.exports =
  Vue.component 'patient-form',
    template: Helpers.template 'patients/form'
    data:
      namePattern: /[A-Z][a-z]*, [A-Z][a-z]* [A-Z]$/
      mobilePattern: /\d{4}-\d{3}-\d{4}/
      landlinePattern: /\d{3}-\d{4}/
      emailPattern: /\w+@[a-z][a-z0-9\-]+[a-z0-9].[a-z]{2,3}/
    methods:
      validateBirthdate: (value) ->
        date = moment(value, "MMM D, YYYY", true)
        date.isValid() and date <= moment()
      createPatient: ->
        queryString = ""
        for key, value of @patient
          if value then queryString += "#{key}=\"#{value}\"&"
        "?" + queryString[0..-2]
