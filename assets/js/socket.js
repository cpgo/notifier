// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import { Socket } from "phoenix";

// let socket = new Socket("/socket", {params: {token: window.userToken}})
let socket = new Socket("/socket", { params: {} });

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect();

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("events:*", {});
channel
  .join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => {
    console.log("Unable to join", resp);
  });

channel.push("events:*", { message: "Hello Phoenix!" });

// %{
//   action: "INSERT",
//   data: %{
//     body: "name",
//     column_id: 1,
//     id: 18,
//     inserted_at: "2020-03-06T00:10:45",
//     updated_at: "2020-03-06T00:10:45"
//   },
//   table: "cards"
// }

const allowDrop = (ev) => {
  ev.preventDefault()
}

const drag = (ev) => {
  ev.dataTransfer.setData("text", ev.target.id)
}

const drop = (ev) => {
  ev.preventDefault()
  let data = ev.dataTransfer.getData("text")
  ev.target.appendChild(document.getElementById(data))
}

channel.on("trigger", res => {
  console.log(res);
  if (res.action === "UPDATE") {
    let targetColumn = document.getElementById(`column-${res.data.column_id}`);
    let card = document.getElementById(`card-${res.data.id}`);
    card.draggable = true
    targetColumn.appendChild(card);
  }
});

channel.on("trigger", res => {
  if (res.action === "INSERT") {
    let targetColumn = document.getElementById(`column-${res.data.column_id}`);
    var card = document.createElement("li");
    card.id = `card-${res.data.id}`;
    card.draggable = true
    card.textContent = res.data.body;
    card.addEventListener("dragstart", (e) => console.log(e));
    targetColumn.appendChild(card)
  }
});

channel.on("trigger", res => {
  if (res.action === "DELETE") {
    let card = document.getElementById(`card-${res.data.id}`);
    card.remove()
  }
});

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

export default socket;
