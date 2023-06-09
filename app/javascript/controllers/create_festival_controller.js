import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-festival"
export default class extends Controller {
  connect() {
  }

  createFestival(e) {
    console.log("Submit via fetch")

    fetch
  }
}
