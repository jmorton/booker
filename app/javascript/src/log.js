document.addEventListener("turbolinks:load", function() {
  console.log("turbolinks:load");
})

document.addEventListener("turbolinks:before-cache", function() {
  console.log("turbolinks:before-cache");
})

document.addEventListener("turbolinks:before-render", function() {
  console.log("turbolinks:before-render");
})

document.addEventListener("ajax:before", function(it) {
  console.log("ajax:before");
})

document.addEventListener("ajax:beforeSend", function() {
  console.log("ajax:beforeSend");
})

document.addEventListener("ajax:send", function() {
  console.log("ajax:send");
})

document.addEventListener("ajax:stopped", function() {
  console.log("ajax:stopped");
})

document.addEventListener("ajax:success", function(it) {
  console.log("ajax:success");
})

document.addEventListener("ajax:error", function() {
  console.log("ajax:error")
})

document.addEventListener("ajax:complete", function() {
  console.log("ajax:complete")
})
