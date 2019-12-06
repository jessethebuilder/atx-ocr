//= require jquery
//= require turbolinks
//= require jquery_ujs
//= require jquery-ui/widgets/draggable
//= require jquery-ui/widgets/droppable
//= require bootstrap
//= require farm_shed/all.js
//= require mail_queue_builder
//= require mail_queuer
//= require mail_image_request_completer
//= require mail_queue_popovers
//= require mail_image_requests

function initClientForm(){
  // BootstrapRailsForm is a custom function defined in farm_shed
  var form = new BootstrapRailsForm('form');
  if(typeof form != 'undefined'){
    form.all();
  }
}

$(document).on('turbolinks:load', function(){
  // Main doc ready
  initClientForm();
});


function normalizeMailImageHeights(){
  $('.mail_images').each(function(i, row){
    var h = $(row).height() + 10;
    $(row).find('.mail_image').css('height', h + 'px');
  });
}
