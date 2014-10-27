module.exports =
  Vue.component 'patients',
    template: Helpers.template 'patients/index'
    data:
      patients: Helpers.get_data("patients")
