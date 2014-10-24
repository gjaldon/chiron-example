module.exports =
  Vue.directive "modal",
    bind: (value) ->
      el = @el
      el.className= "modal"
      el.style.display = "none"
      Helpers.addAnimationEndEvent el, @endAnimationHandler
      @addOverlay()

    update: (value) ->
      overlay = @vm.$root.$el.getElementsByClassName('overlay')[0]
      if value
        @el.classList.remove "v-leave"
        overlay.classList.remove "v-leave"
        @el.classList.add "v-enter"
        overlay.classList.add "v-enter"
        @el.style.display = ""
        overlay.style.display = ""
      else
        @el.classList.add "v-leave"
        overlay.classList.add "v-leave"

    unbind: ->
      el = @el
      Helpers.removeAnimationEndEvent el, @endAnimationHandler
      overlay = @vm.$root.$el.getElementsByClassName('overlay')[0]
      overlay.remove()

    endAnimationHandler: ->
      if @classList.contains "v-leave"
        @classList.remove "v-leave"
        @style.display = "none"

    addOverlay: ->
      overlay = document.createElement "div"
      overlay.className = "overlay"
      overlay.style.display = "none"
      overlay.addEventListener "click", => @vm.$root[@key] = false
      Helpers.addAnimationEndEvent overlay, @endAnimationHandler
      @vm.$root.$el.appendChild overlay
