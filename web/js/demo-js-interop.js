(function () {
  "use strict";

  window._stateSet = function () {
    window._stateSet = function () {
      console.log("Call _stateSet once");
    };

    let appState = window._appState;

    let valueField = document.querySelector("#value");
    let updateState = function () {
      // valueField.value = appState.count;
    };

    //Register a callback to update the HTML  field from Flutter
    appState.addHandler(updateState);

    //Render the first value -- 0
    updateState();

    // let incremetButton = document.querySelector("#increment");
    // incrementButton.addEventListener("click", (event) => {
    //   appState.increment();
    // });
    let moveRive = document.querySelector("#forward");
    moveRive.addEventListener("click", (event) => {
      console.log("Pressed move");
      appState.moveRive();
    });

    let button = document.querySelector("#newpage");
    button.addEventListener("click", (event) => {
      console.log("Pressed");
      appState.playRive();
    });
  };
})();
