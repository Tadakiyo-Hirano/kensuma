// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('admin-lte');
require("jquery");
require ("./users/auth");
require("packs/jquery.jpostal");
require("./orders/postcode");
require("./users/select2");
require("./users/input_form");

import 'bootstrap';
import '../stylesheets/users';
import "@fortawesome/fontawesome-free/js/all";
import "@nathanvda/cocoon"

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('.multiple-select').select2({
    width: 'resolve',
    theme: 'classic',
    multiple: 'multiple',
    allowClear: true
  }),
  $('.single-select').select2({
    width: 'resolve',
    placeholder: '選択してください',
    theme: 'classic',
    allowClear: true,
    tags: true,
    language: {
      "noResults": function() {
        return "入力してください";
      }
    },
    escapeMarkup: function (markup) {
      return markup;
    }
  })
});

// 強制リロード
history.pushState(null, null, location.href);
window.addEventListener('pageshow', function (event) {
  if (event.persisted) {
    window.location.reload();
  }
});

// ブラウザバック禁止
window.addEventListener('popstate', (e) => {
  let isBackAllowed = false;
  if (!isBackAllowed) {
    history.pushState(null, null, location.href);
    history.go(1);
    alert('ブラウザバックは使えません。');
  } else {
    isBackAllowed = false;
  }
});

window.addEventListener('beforeunload', function(event) {
  isBackAllowed = true;
});


import 'select2';                       // globally assign select2 fn to $ element
import 'select2/dist/css/select2.css';  // optional if you have css loader

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
