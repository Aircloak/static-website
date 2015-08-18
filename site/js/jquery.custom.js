/* jquery custom */

$(document).ready(function(){
	
	$(".nav_responsive").click(function(){
		$("nav > ul").slideToggle("600");
		$(".nav_responsive").toggleClass("close_menu");
	});
	
	// Scrolling Anker-Link 
	// Reminder for Dummies: Link <a href="#services">Jump to services</a> / Anker <div id="services"></div>
	$('a[href^="#"]').on('click', function(e) {
		e.preventDefault();

		var target = this.hash,
			$target = $(target);

		$('html, body').stop().animate({
			'scrollTop': $target.offset().top
		}, 400, 'swing', function() {
			window.location.hash = target;
		});
	});
	
	$('.middle').vAlign();
		
});

// vertical-align: middle

$.fn.vAlign = function() {
	return this.each(function(i){
	var ah = $(this).height();
	var ph = $(this).parent().height();
	var mh = Math.ceil((ph-ah) / 2);
	$(this).css('margin-top', mh);
	});
};		
