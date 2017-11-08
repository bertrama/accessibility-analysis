// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('button[data-toggle]').click(function(e) {
    $(this).toggleClass('active');
    var active = $.makeArray($('button.active[data-toggle]').map(function () {
      return $(this).data('toggle');
    })).join(',');
    var inactive = $.makeArray($('button[data-toggle]:not(.active)').map(function(){
      return $(this).data('toggle')
    })).join(',');
    $(active).not(inactive).show();
    $(inactive).hide()
  });

  $('button[data-id]').click(function(e){
    $('#highlight').remove();
    $('body').append('<div id="highlight"></div>');
    $('#highlight').load('/message/' + $(this).data('id'));
  });
});
