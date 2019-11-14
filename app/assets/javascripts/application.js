// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap

jQuery(document).ready(function(){
  $('h1').mousemove(function(e){
    var rXP = (e.pageX - this.offsetLeft-$(this).width()/2);
    var rYP = (e.pageY - this.offsetTop-$(this).height()/2);
    $('h1').css('text-shadow', +rYP/10+'px '+rXP/80+'px rgba(243,243,243,1), '+rYP/8+'px '+rXP/60+'px rgba(114,98,87,0.8), '+rXP/70+'px '+rYP/12+'px rgba(217,224,33,0.5)');
  });
});