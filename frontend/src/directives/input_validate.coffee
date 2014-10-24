module.exports = Vue.directive 'input-validate',
  bind: (value) ->
    @input = @el
    @errorDiv = document.createElement "div"
    @errorDiv.className = "input-error v-enter"
    @errorDiv.textContent = "Follow the format: #{@input.placeholder}"
    @errorDiv.style.display = "none"
    Helpers.addAnimationEndEvent @errorDiv, =>
      if @errorDiv.classList.contains "v-leave"
        @errorDiv.style.display = "none"
    @input.parentElement.appendChild @errorDiv

  update: (value) ->
    if value and value.match(/[A-Z][a-z]*, [A-Z][a-z]* [A-Z]$/)
      @input.classList.remove "input-invalid"
      @input.classList.add "input-valid"
      @hideError()
    else if value and !@input.classList.contains "input-invalid"
      @addOrShowError()
      @input.classList.remove "input-valid"
      @input.classList.add "input-invalid"
    else if !value
      @input.classList.remove "input-invalid"
      @input.classList.remove "input-valid"
      @hideError()

  unbind: (value) ->
    @errorDiv.remove()

  addOrShowError: ->
    @errorDiv.className = "input-error v-enter"
    @errorDiv.style.display = ""

  hideError: ->
    @errorDiv?.className = "input-error v-leave"

