import "./css/ui.css";
import "./css/themes/unison-light.css";
import "./css/code.css";
import "./UI/CopyOnClick"; // Include web components
import "./UI/OnclickOutside"; // Include web components
import detectOs from "ui-core/Lib/detectOs";
import preventDefaultGlobalKeyboardEvents from "ui-core/Lib/preventDefaultGlobalKeyboardEvents";

import "./css/unison-local.css";
import { Elm } from "./ScriptoriumWeb.elm";

console.log(`
 _____     _
|  |  |___|_|___ ___ ___
|  |  |   | |_ -| . |   |
|_____|_|_|_|___|___|_|_|
`);

const basePath = new URL(document.baseURI).pathname;

let apiUrl;

if (basePath === "/") {
  apiUrl = "api";
} else {
  apiUrl = basePath.replace("ui", "api");
}

const flags = {
  //operatingSystem: detectOs(window.navigator),
  basePath,
  apiUrl,
};

preventDefaultGlobalKeyboardEvents();

// The main entry point for the `UnisonLocal` target of the Codebase UI.
Elm.Main.init({ flags });
