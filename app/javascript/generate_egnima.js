// This part was help with AI.
document.addEventListener('turbo:load', () => {
  const generateBtn = document.getElementById('generate-with-ai-btn');
  // Only happens if generateBtn is detected
  if (generateBtn) {
    generateBtn.addEventListener('click', async () => {
      const url = generateBtn.dataset.url; // get URL from button's data-url Gets "/challenges/create_with_ai"
      const loading = document.getElementById('ai-loading');

      // Show loading
      generateBtn.disabled = true;
      loading.classList.remove('d-none');

      try {
        const response = await fetch(url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content // require this for safety & rails
          }
        });

        const data = await response.json();

        // Fill the form fields
        document.getElementById('challenge_title').value = data.title;
        document.getElementById('challenge_description').value = data.description;

      } catch (error) {
        console.error('Error:', error);
        alert('Failed to generate. Please try again.');
      } finally {
        // Hide loading
        generateBtn.disabled = false;
        loading.classList.add('d-none');
      }
    });
  }
});
