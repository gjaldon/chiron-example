`import DS from 'ember-data'`

ApplicationSerializer = DS.RESTSerializer.extend
  primaryKey: '_id'

`export default ApplicationSerializer`
