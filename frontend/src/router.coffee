App.Router.map ->
  @resource 'patients', ->
    @route 'new'
    @route 'edit', path: ':patient_id/edit'
