`import DS from 'ember-data'`

attr = DS.attr

Patient = DS.Model.extend
  name: attr 'string'
  main_contact: attr 'string'
  birthdate: attr 'string'

`export default Patient`
