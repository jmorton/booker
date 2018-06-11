/*
 * Replace an existing element with a new element, created from an AJAX response.
 *
 * This is a generic handler; it makes a lot of assumptions about the structure
 * of the DOM and the response.
 *
 * Assupmtion #1: There is an HTML fragment in the AJAX detail's response text.
 * Assumption #2: The root element(s) of the fragment each have an ID.
 * Assumption #3: There is an element in the DOM with the same ID.
 *
 * These three assumptions inform a convention: the application responds to AJAX
 * requests with partial content that is suitable for the DOM.
 *
 */
function swapper(it) {
  // no pushstate...
  try {
    console.log("swapping fragments");
    var text = it.detail[0].responseText;
    var frag = document.createRange().createContextualFragment(text);
    for (let child of frag.children) {
      var orig = document.getElementById(child.id);
      orig.replaceWith(child);
    }
  } catch (error) {
    console.error(error);
  }
}

document.addEventListener("ajax:complete", swapper);
