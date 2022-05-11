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

import 'bootstrap';
import '../stylesheets/users';
import "@fortawesome/fontawesome-free/js/all";
import "@nathanvda/cocoon"
import 'select2'
import 'select2/dist/css/select2.css'

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('.js-select').select2({
    // multiple: "multiple",
    placeholder: '作業員を選択',
    allowClear: true
  })
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
