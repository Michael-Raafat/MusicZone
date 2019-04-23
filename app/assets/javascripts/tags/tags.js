function swapSelection(btn) {
  if (btn.parentElement.className === "btn btn-rounded btn-lg btn-success") {
    btn.parentElement.className = "btn btn-rounded btn-lg btn-default";
  } else {
    btn.parentElement.className = "btn btn-rounded btn-lg btn-success";
  }
}
