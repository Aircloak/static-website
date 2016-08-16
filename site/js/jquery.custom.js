/* jquery custom */

$(document).ready(function() {

	$(".nav_responsive").click(function() {
		$("nav > ul").slideToggle("600");
		$(".nav_responsive").toggleClass("close_menu");
	});

	// Scrolling Anker-Link 
	// Reminder for Dummies: Link <a href="#services">Jump to services</a> / Anker <div id="services"></div>
	// smooth scroll
	$('a[href^="#"]').on('click', function(e) {
		e.preventDefault();

		var target = this.hash,
			$target = $(target);

		$('html, body').stop().animate({
			'scrollTop': $target.offset().top
		}, 900, 'swing', function() {
			window.location.hash = target;
		});
	});
	
	// bxslider ref-slider

	if (window.matchMedia('(min-width: 500px)').matches) {
		$('.ref-slider').bxSlider({
			auto: true,
			speed: '2000',
			infiniteLoop: true,
			responsive: true,
			pager: false,
			controls: false,
			touchEnabled: true,
			preloadImages: true,
			slideWidth: 260,
			slideMargin: 0,
			minSlides: 1,
			maxSlides: 4,
			moveSlides: 1
		});
	}
	if (window.matchMedia('(max-width: 500px)').matches) {
		$('.ref-slider').bxSlider({
			auto: true,
			speed: '2000',
			infiniteLoop: true,
			responsive: true,
			pager: false,
			controls: false,
			touchEnabled: true,
			preloadImages: true,
			minSlides: 1,
			maxSlides: 1,
			moveSlides: 1
		});
	}

	// bxslider news-slider
	if (window.matchMedia('(min-width: 500px)').matches) {
		$('.news-slider').bxSlider({
			auto: true,
			speed: '2000',
			infiniteLoop: true,
			pager: false,
			controls: true,
			adaptiveHeight: true,
			adaptiveHeightSpeed: 700,
			responsive: true,
			touchEnabled: true,
			preloadImages: true,
			slideWidth: 220,
			slideMargin: 40,
			minSlides: 1,
			maxSlides: 4,
			moveSlides: 1
		});
	}
	if (window.matchMedia('(max-width: 500px)').matches) {
		$('.news-slider').bxSlider({
			auto: true,
			speed: '2000',
			infiniteLoop: true,
			pager: true,
			controls: false,
			adaptiveHeight: true,
			adaptiveHeightSpeed: 700,
			responsive: true,
			touchEnabled: true,
			preloadImages: true,
			minSlides: 1,
			maxSlides: 1,
			moveSlides: 1
		});
	}

});