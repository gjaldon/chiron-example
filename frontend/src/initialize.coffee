Vue   = require 'vue'

starter = new Vue
  el: "#app"
  data:
    title: "Chiron start"
    todos: [
      {
        done: true
        content: "Learn Javascript"
      }
      {
        done: false
        content: "Learn Vue.js"
      }
    ]
