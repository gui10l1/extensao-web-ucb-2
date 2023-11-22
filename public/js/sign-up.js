const form = document.getElementById('form');

async function handleFormSubmit(event) {
  event.preventDefault();

  const formData = new FormData(event.target);

  const password = formData.get('password');
  const confirmPassword = formData.get('confirmPassword');

  if (password !== confirmPassword) {
    alert('As senhas não são iguais!');
    return;
  }

  event.target.submit();
}

form.addEventListener('submit', handleFormSubmit);