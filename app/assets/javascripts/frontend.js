//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery2
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/datepicker
//= require jquery-ui/position
//= require_tree ./frontend

$(function() {
  // Initializes and creates emoji set from sprite sheet
  window.emojiPicker = new EmojiPicker({
      emojiable_selector: '[data-emojiable=true]',
  assetsPath: '../img/emoji',
  popupButtonClasses: 'sticker'
  });
  // Finds all elements with `emojiable_selector` and converts them to rich emoji input fields
  // You may want to delay this step if you have dynamically created input fields that appear later in the loading process
  // It can be called as many times as necessary; previously converted input fields will not be converted again
  window.emojiPicker.discover();
  });

