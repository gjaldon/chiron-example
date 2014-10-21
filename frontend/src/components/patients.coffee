Patients = Vue.component 'patients',
  template: Helpers.template 'patients/index'
  data:
    patients: [
      {
        name: "Jaldon, Gabriel"
        mainContact: "09173120698"
        lastVisit: "Jan 25, 2010"
      }
      {
        name: "Famador, Regina"
        mainContact: "09173120699"
        lastVisit: "Jan 25, 2011"
      }
    ]

module.exports = Patients
