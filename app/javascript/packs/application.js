import 'core-js/stable'
import 'regenerator-runtime/runtime'
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require activestorage
//= require nprogress
//= require nprogress-turbolinks
//= require typeahead.bundle
//= require commontator/application
//= require_tree .
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("packs/dropdown")
require("packs/users")
require("@rails/ujs").start()
require("jquery")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
jQuery(document).ready(function () {
  var videos = new Bloodhound({
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/cs/autocomplete?query=%QUERY',
      wildcard: '%QUERY' 
    }
  });
  videos.initialize();
  $('.search').typeahead(null, {
    name: 'videos',
    source: videos
  });
});