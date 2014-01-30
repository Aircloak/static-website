/* jquery custom */

$(document).ready(function(){

	$(".include").each(function(){
	    var inc=$(this);
	    $.get(inc.attr("title"), function(data){
	        inc.replaceWith(data);
	    });
	});
	
	//<div class="include" title="title.html"></div>

	// open or close box 
	$(".nav_responsive").click(function(){ // trigger
	      $("ul.nav_main").slideToggle("600"); // show hidden text
	      $(".nav_responsive").toggleClass("open closed"); // changing class
	});
	
	/* Navi Main Drop-Down-Menu*/
	
	$(".nav_main li:has(ul)").hover(function(){
		$(this).find("ul").slideDown(100);
	}, function(){
		$(this).find("ul").slideUp(100);
	});	
	
	/* accordion */
	
	$(document).ready( function() {
		$('.trigger').not('.trigger_active').next('.toggle_container').hide();
		$('.trigger').click( function() {
			var trig = $(this);
			if ( trig.hasClass('trigger_active') ) {
				trig.next('.toggle_container').slideToggle('slow');
				trig.removeClass('trigger_active');
			} else {
				$('.trigger_active').next('.toggle_container').slideToggle('slow');
				$('.trigger_active').removeClass('trigger_active');
				trig.next('.toggle_container').slideToggle('slow');
				trig.addClass('trigger_active');
			};
			return false;
		});
	});
		
	
});