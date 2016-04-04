//= require jquery
//= require jquery.timeTo.min
//= require jquery_ujs
//= require twitter/bootstrap
//= require js-routes
//= require underscore
//= require_tree ./templates
//= require_tree ./web

$(function() {
  if (window.pluso)if (typeof window.pluso.start == "function") return;
  if (window.ifpluso==undefined) { window.ifpluso = 1;
  var d = document, s = d.createElement('script'), g = 'getElementsByTagName';
  s.type = 'text/javascript'; s.charset='UTF-8'; s.async = true;
  s.src = ('https:' == window.location.protocol ? 'https' : 'http')  + '://share.pluso.ru/pluso-like.js';
  var h=d[g]('body')[0];
  h.appendChild(s);
}});

$(document).ready(function(){
  $('.programms__items').slick({
      dots: false,
      infinite: false,
      speed: 1000,
      slidesToShow: 6,
      slidesToScroll: 1,
      responsive: [
        {
          breakpoint: 979,
          settings: {
            slidesToShow: 4,
            slidesToScroll: 1,
            infinite: false,
            dots: false
          }
        },
        {
          breakpoint: 620,
          settings: {
            slidesToShow: 1,
            slidesToScroll: 1
          }
        }
      ]
    });
});
