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

  $(document).on('click', '#close', function() {
    $('#highlight').html('');
  })

  $('button[data-id]').click(function(e){
    $('#highlight').html('');
    var reference = $('img').get(0);
    $('#highlight').load('/messages/' + $(this).data('id'),
      (function(reference) {
        return function() {
          var scale_width = reference.width/reference.naturalWidth;
          var scale_height = reference.height/reference.naturalHeight;
          $('.message').css('width', reference.width + 'px');
          var hl = $('.outline');
          var width = parseInt(hl.css('width'));
          var height = parseInt(hl.css('height'));
          var top = parseInt(hl.css('margin-top'));
          var left = parseInt(hl.css('margin-left'));
          hl.css('width', Math.ceil(width *scale_width) + 'px')
            .css('height', Math.ceil(height * scale_height) + 'px')
            .css('margin-left', Math.ceil(left * scale_width) + 'px')
            .css('margin-top', Math.ceil(top * scale_height) + 'px');
        };
      } (reference)));


  });
});
