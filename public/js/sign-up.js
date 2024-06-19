const form = document.getElementById('form');

const validator = document.getElementById('validator');

async function handleFormSubmit(event) {
  event.preventDefault();

  validator.textContent = null;

  const formData = new FormData(event.target);

  const password = formData.get('password');
  const confirmPassword = formData.get('confirmPassword');

  if (password !== confirmPassword) {
    validator.textContent = 'As senhas não são iguais!';
    return;
  }

  event.target.submit();
}

form.addEventListener('submit', handleFormSubmit);