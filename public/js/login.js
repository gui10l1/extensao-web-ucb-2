const formElement = document.getElementById('form');

async function handleFormSubmit(event) {
  event.target.preventDefault();

  event.target.submit();
}

formElement.addEventListener('submit', handleFormSubmit);