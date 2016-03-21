
jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
  });

  $('#filter_for_users').on('change.fs', function(){
    $.getScript($('#filter_for_users option:selected').data("href"));
    return false;
  });

  $("#submit").attr("disabled", true);
  $("#privacy").click(function () {
    $("#submit").attr("disabled", !this.checked);
  });
})

$(window).on("load", function () {
    blockPermutationInfo();
});
$(window).on("resize", function () {
    blockPermutationInfo();
});


function blockPermutationInfo() {
    var window_width = $(window).width();

    if (window_width < 620) {
        $(".registration__form").prepend($(".personal__identity__number").eq(0).detach());
    } else if (window_width >= 620) {
        $(".personal__identity__social").before($(".personal__identity__number").eq(0).detach());
    }
}
