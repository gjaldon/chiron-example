module.exports =
  Vue.directive "modal",
    bind: (value) ->
      el = @el
      el.className= "modal"
      el.style.display = "none"
      for event in animationendEvents
        el.addEventListener event, @endAnimationHandler

    update: (value) ->
      root = @vm.$root.$el
      if value
        overlay = document.createElement "div"
        overlay.className = "overlay"
        overlay.addEventListener "click", => @vm.$root[@key] = false
        for event in transitionendEvents
          overlay.addEventListener event, -> @remove()
        root.appendChild overlay
        @el.classList.add "v-enter"
        @el.style.display = ""
      else if overlay = root.getElementsByClassName('overlay')[0]
          overlay.classList.add "v-leave"
          @el.classList.add "v-leave"

    unbind: () ->
      el = @el
      for event in animationendEvents
        el.removeEventListener event, @endAnimationHandler

    endAnimationHandler: ->
      if @classList.contains "v-leave"
        @classList.remove "v-leave"
        @style.display = "none"

animationendEvents = ["webkitAnimationEnd", "animationend", "MSAnimationEnd", "oanimationend"]
transitionendEvents = ["transitionend", "webkitTransitionEnd", "oTransitionEnd", "MSTransitionEnd"]
