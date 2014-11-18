`import DS from 'ember-data'`

attr = DS.attr

Patient = DS.Model.extend
  name: attr 'string'
  main_contact: attr 'string'
  birthdate: attr 'string'

Patient.reopenClass
  FIXTURES: [
    {id: 1, name: "Foo Bar", main_contact: "09173019000", birthdate: "April 23, 2000"}
    {id: 2, name: "Bar Foo", main_contact: "09173019001", birthdate: "April 23, 2001"}
  ]

`export default Patient`
