`import DS from 'ember-data'`

set = Ember.set
get = Ember.get

ApplicationAdapter = DS.RESTAdapter.extend
  host: 'http://localhost:4000'
  namespace: 'api'

  deleteRecord: (store, type, record) ->
    id = get(record, 'id')
    rev = record._data._rev
    headers = {"If-Match": rev}

    set(@, 'headers', headers)
    @ajax(@buildURL(type.typeKey, id, record), "DELETE")

  updateRecord: (store, type, record) ->
    data = {}
    serializer = store.serializerFor(type.typeKey)

    serializer.serializeIntoHash(data, type, record, {includeId: true})
    id = get(record, 'id')
    data.patient._rev = record._data._rev
    @ajax(@buildURL(type.typeKey, id, record), "PUT", {data: data})

`export default ApplicationAdapter`
