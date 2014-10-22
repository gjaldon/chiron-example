Patients = Vue.component 'patients',
  template: Helpers.template 'patients/index'
  data:
    patients: Helpers.get_data("#{api_host}/patients")

module.exports = Patients
