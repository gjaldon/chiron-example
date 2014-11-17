`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @resource 'patients', ->
    @route 'new'
    @route 'edit', path: ':patient_id/edit'

`export default Router`
