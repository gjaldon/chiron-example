page = require 'page'

module.exports =
  Vue.directive "modal",
    bind: (value) ->
      @el.className= "modal"
      @el.style.display = "none"
      Helpers.addAnimationEndEvent @el, @endAnimationHandler
      @addOverlay()

    update: (value) ->
      if value
        @el.classList.remove "v-leave"
        @overlay.classList.remove "v-leave"
        @el.classList.add "v-enter"
        @overlay.classList.add "v-enter"
        @el.style.display = ""
        @overlay.style.display = ""
      else
        @el.classList.add "v-leave"
        @overlay.classList.add "v-leave"

    unbind: ->
      Helpers.removeAnimationEndEvent @el, @endAnimationHandler
      @overlay.remove()

    endAnimationHandler: ->
      if @classList.contains "v-leave"
        @classList.remove "v-leave"
        @style.display = "none"

    addOverlay: ->
      @overlay = document.createElement "div"
      @overlay.className = "overlay"
      @overlay.style.display = "none"
      @overlay.addEventListener "click", =>
        @vm.$root[@key] = false
        page(@el.dataset.redirectpath)
      Helpers.addAnimationEndEvent @overlay, @endAnimationHandler
      @vm.$root.$el.appendChild @overlay
