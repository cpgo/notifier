export const addEvents = () => {
  document.addEventListener("dragover", function (event) {
    event.preventDefault();
  });
  Array.from(document.querySelectorAll('[draggable]')).map((card) => {
    card.addEventListener("dragstart", dragStarted);
  })

  document.addEventListener("dragover", function (event) {
    event.preventDefault();
  });

  document.addEventListener("drop", dropped)

}

export const dragStarted = (event) => {
  event.dataTransfer.setData("text/plain", event.target.dataset.id)
}

export const dropped = (event) => {
  event.preventDefault()
  const cardId = event.dataTransfer.getData("text/plain")
  const columnId = event.target.closest(".list").querySelector("ul").dataset.id
  var headers = new Headers();
  headers.append("Content-Type", "application/json");

  var payload = JSON.stringify({ "card": { "column_id": columnId } });

  var requestOptions = {
    method: 'PUT',
    headers: headers,
    body: payload,
    redirect: 'follow'
  };

  fetch(`/json/cards/${cardId}`, requestOptions)
    .then(response => response.text())
    .then(result => console.log(result))
    .catch(error => console.log('error', error));
}
