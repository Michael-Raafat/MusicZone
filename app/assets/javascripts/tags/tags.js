function swapSelection(btn) {
  if (btn.parentElement.classList.contains("btn-success")) {
    btn.parentElement.classList.remove("btn-success");
    btn.parentElement.classList.add("btn-default");
  } else {
    btn.parentElement.classList.remove("btn-default");
    btn.parentElement.classList.add("btn-success");
  }
}
