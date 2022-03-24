import { Elm } from "./Main.elm";

var app = Elm.Main.init({ node: document.getElementById("root") });
app.ports.play.subscribe(function (data) {
    console.log("chew");
    var x = document.getElementById("chew");
    x.play();
});
