Vue = require 'vue'

TestComponent = Vue.component 'test',
  template: Helpers.template 'test'

module.exports = TestComponent
