// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("bootstrap/dist/js/bootstrap")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
// $(document).ready(function () {

//     var current_fs, next_fs, previous_fs; //fieldsets
//     var opacity;

//     $(".next").click(function () {

//         current_fs = $(this).parent();
//         next_fs = $(this).parent().next();

//         //Add Class Active
//         $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

//         //show the next fieldset
//         next_fs.show();
//         //hide the current fieldset with style
//         current_fs.animate({ opacity: 0 }, {
//             step: function (now) {
//                 // for making fielset appear animation
//                 opacity = 1 - now;

//                 current_fs.css({
//                     'display': 'none',
//                     'position': 'relative'
//                 });
//                 next_fs.css({ 'opacity': opacity });
//             },
//             duration: 600
//         });
//     });

//     $(".previous").click(function () {

//         current_fs = $(this).parent();
//         previous_fs = $(this).parent().prev();

//         //Remove class active
//         $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

//         //show the previous fieldset
//         previous_fs.show();

//         //hide the current fieldset with style
//         current_fs.animate({ opacity: 0 }, {
//             step: function (now) {
//                 // for making fielset appear animation
//                 opacity = 1 - now;

//                 current_fs.css({
//                     'display': 'none',
//                     'position': 'relative'
//                 });
//                 previous_fs.css({ 'opacity': opacity });
//             },
//             duration: 600
//         });
//     });

//     $('.radio-group .radio').click(function () {
//         $(this).parent().find('.radio').removeClass('selected');
//         $(this).addClass('selected');
//     });

//     $(".submit").click(function () {
//         return false;
//     })

// });


