import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="generate-enigma"
export default class extends Controller {
  static targets = ["title", "description", "loading", "generate"]

  async generate() {
    const url = this.generateTarget.dataset.url;
    this.generateTarget.disabled = true;
    this.loadingTarget.classList.remove("d-none");

    const response = await fetch(url, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content // require this for safety & rails
      }
    });

    const data = await response.json();

    // Fill the form fields
    this.titleTarget.value = data.title;
    this.descriptionTarget.value = data.description;

    this.generateTarget.disabled = false;
    this.loadingTarget.classList.add('d-none');
  }
}

// method generate
// target challenge_title and target challenge_description
// target target ai-loading
