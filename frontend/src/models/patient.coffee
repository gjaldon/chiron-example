attr = DS.attr

App.Patient = DS.Model.extend
  name: attr 'string'
  main_contact: attr 'string'
  birthdate: attr 'string'
