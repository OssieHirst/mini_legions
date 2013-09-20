// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

/* Count the number of characters in a micropost. */
function countCharacters(textField, charCountLabel, maxLength) {
  var currentLength = textField.value.length;
  if (currentLength > maxLength) {
    // Trim the text, if it exceeds max length.
    textField.value = textField.value.substring(0, maxLength);
  } else {
    // Update characters remaining counter label.
    charCountLabel.innerHTML = maxLength - currentLength;
  }
}