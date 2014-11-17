App.ModalDialogComponent = Ember.Component.extend
  actions:
    closeModal: ->
      @sendAction()

  willInsertElement: ->
    @$('.overlay').addClass('animate-enter')
    @$('.modal').addClass('animate-enter')
