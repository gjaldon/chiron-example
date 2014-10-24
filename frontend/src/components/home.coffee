module.exports =
  Vue.component 'home',
    template: Helpers.template 'home'
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
