$(document).ready(function(){
    $('#about_site').click( function() {
	var element = document.getElementById('introduction');
	if ($('#introduction').hasClass('invisible')) {
	    element.style.display = 'block';
	    $('#introduction').removeClass('invisible');
	    $('#introduction').addClass('visible');
	}else {
	    element.style.display = 'none';
	    $('#introduction').removeClass('visible');
	    $('#introduction').addClass('invisible');
	}
    });
});
