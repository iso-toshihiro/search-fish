function mapInitialize() {
    var first_position = new google.maps.LatLng(35.6809691281986,139.7668620944023);
    var opts = {
	zoom: 5,
	center: first_position,
	mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map_canvas"), opts);

    $.ajax({type: 'GET',
	    url:  '/diving_spots/coordinates',
	    Type: 'json',
	    success: function(res){
		for( var i = 0 ; i < res.coordinates.length; i++) {
		    var position = new google.maps.LatLng(res.coordinates[i][0], res.coordinates[i][1]);
		    new google.maps.Marker({
			position: position,
			map: map
		    });
		}
	    }
	   });
};

$(document).ready(function(){
    mapInitialize();

    function displaiedSpots(value) {
	var element =  document.getElementById("spot_id_" + value );
        element.style.display = 'block';
    }

    function invisibleSpots(value) {
        var element =  document.getElementById("spot_id_" + value );
        element.style.display = 'none';
    }

    $('#spot_search').change(function(e){
	var word = $(this).val();
        $.ajax({type: 'GET',
		url:  '/diving_spots/search',
                data: { keyword: word },
                Type: 'json',
                success: function(res){
                    res.all_ids.forEach(invisibleSpots);
		    res.display_ids.forEach(displaiedSpots);
                }
	       });
    });
});
