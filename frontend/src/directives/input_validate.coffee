module.exports = Vue.directive 'input-validate',
  bind: (value) ->
    @input = @el
    @errorDiv = document.createElement "div"
    @errorDiv.className = "input-error v-enter"
    @errorDiv.textContent = @errorMessage()
    @errorDiv.style.display = "none"
    Helpers.addAnimationEndEvent @errorDiv, =>
      if @errorDiv.classList.contains "v-leave"
        @errorDiv.style.display = "none"
    @input.parentElement.appendChild @errorDiv
    if @vm.validityChecks == undefined then @vm.validityChecks = {}

  update: (value) ->
    if @isValid(value)
      @setInputToValid()
    else if value and !@input.classList.contains "input-invalid"
      @addOrShowError()
      @setInputToInvalid()
    else if !value and @input.required
      @setInputToInvalid()
    else if !value
      @input.classList.remove "input-invalid"
      @input.classList.remove "input-valid"
      @hideError()
    @checkFormValidity()

  setInputToInvalid: ->
    @input.classList.remove "input-valid"
    @input.classList.add "input-invalid"
    @vm.validityChecks[@key] = false

  setInputToValid: ->
    @input.classList.remove "input-invalid"
    @input.classList.add "input-valid"
    @hideError()
    @vm.validityChecks[@key] = true

  isValid: (value) ->
    if (typeof @vm[@arg]) == "object"
      pattern = @vm[@arg]
      value?.match(pattern)
    else if (typeof @vm[@arg]) == "function"
      @vm[@arg](value)

  unbind: (value) ->
    @errorDiv.remove()

  addOrShowError: ->
    @errorDiv.className = "input-error v-enter"
    @errorDiv.style.display = ""

  hideError: ->
    @errorDiv?.className = "input-error v-leave"

  errorMessage: ->
    if customMsg = @input.dataset?.errormessage
      "Follow the format: #{@input.placeholder} and #{customMsg}"
    else
      "Follow the format: #{@input.placeholder}"

  checkFormValidity: ->
    validityCounter = 0
    for _key, value of @vm.validityChecks
      if value then validityCounter++
    if validityCounter == Object.keys(@vm.validityChecks).length
      @vm.formValid = true
    else
      @vm.formValid = false

