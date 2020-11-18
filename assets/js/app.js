// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import 'alpinejs'

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import socket from "./socket"
import { addEvents } from "./dragDrop"

addEvents()

window.cardForm = (current_column) => {
  return {
    form: {
      card: {
        body: "",
        column_id: current_column
      }
    },
    submit() {
      // logica de ajax aqui
      console.log(this)
    }
  }
}
