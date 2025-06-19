import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["form"] 

  connect() {
    console.log("Checkbox controller connected!")
  }

  
  submitForm(event) {
    
    console.log("Checkbox changed, submitting form...")
    this.formTarget.requestSubmit() 
  }
}
