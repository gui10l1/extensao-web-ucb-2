const createForm = document.getElementById('form');
const deleteForm = document.getElementsByClassName('deleteForm');
const formToggler = document.getElementById('formToggler');
const cancelFormButton = document.getElementById('cancelForm');

function handleFormToggler() {
  form.style.display = 'flex';
  formToggler.style.display = 'none';
}

function handleCancelFormButton() {
  createForm.setAttribute('action', '/home');
  createForm.setAttribute('method', 'GET');

  createForm.submit();
}

function handleDeleteForm(event) {
  event.preventDefault();

  const isConfirmed = confirm('Voce deseja mesmo excluir esse registro?');

  if (isConfirmed) {
    event.target.submit();
  } else {
    alert('Operação cancelada!');
  }
}

formToggler.addEventListener('click', handleFormToggler);
cancelFormButton.addEventListener('click', handleCancelFormButton);
Array.from(deleteForm).forEach(element => element.addEventListener('submit', handleDeleteForm));