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
  });

  $('button[data-id]').click(function(e){
    var highlight = $('#highlight');
    var reference = $('img').get(0);
    highlight.html('').load('../messages/' + $(this).data('id'),
      (function(reference) {

        function update_outline(scale_width, scale_height) {
          var outline = $('.outline');
          var width = parseInt(outline.css('width'));
          var left = parseInt(outline.css('margin-left'));
          var height = parseInt(outline.css('height'));
          var top = parseInt(outline.css('margin-top'));
          outline.css('width', Math.ceil(width * scale_width) + 'px')
            .css('margin-left', Math.ceil(left * scale_width) + 'px')
            .css('height', Math.ceil(height * scale_height) + 'px')
            .css('margin-top', Math.ceil(top * scale_height) + 'px');
        }

        function update_pointer(scale_width) {
          var pointer = $('.pointer');
          var width = parseInt(pointer.css('width'));
          var left  = parseInt(pointer.css('margin-left'));
          pointer.css('width', Math.ceil(width * scale_width) + 'px')
            .css('margin-left', Math.ceil(left * scale_width) + 'px');
        }

        function scroll() {
          var container = $('html');
          var outline = $('.outline');
          container.scrollTop( outline.offset().top - 25 );
        }

        return function() {
          var scale_width = reference.width/reference.naturalWidth;
          var scale_height = reference.height/reference.naturalHeight;
          $('.message').css('width', reference.width + 'px');
          update_outline(scale_width, scale_height);
          update_pointer(scale_width);
          scroll();
        };
      } (reference)));
  });
});
