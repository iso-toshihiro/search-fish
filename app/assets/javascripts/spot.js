function attachMessage(marker, spot) {
    google.maps.event.addListener(marker, 'click', function(event){
	var windowId = 'spot_marker_window_' + spot.id;
	var url = '/diving_spots/' + spot.id  + '/fishes';
	html = '<a href="' + url + '" id="' + windowId + '" window="open">'+ spot.name + '</a>';

	var infoWindow = new google.maps.InfoWindow({
	    Content: html
	});

	if ( $('#' + windowId).attr('window') != 'open') {
	    infoWindow.open(marker.getMap(), marker);
	}
    });
}

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
		for( var i = 0 ; i < res.spots.length; i++) {
		    if( !res.spots[i].lat ) {
			continue;
		    }
		    var position = new google.maps.LatLng(res.spots[i].lat, res.spots[i].lng);
		    var marker = new google.maps.Marker({
			position: position,
			map: map,
			title: res.spots[i].name
		    });
		    attachMessage(marker, res.spots[i]);
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
	var abroad = $("select option:selected").val();
	var word = $(this).val();
        $.ajax({type: 'GET',
		url:  '/diving_spots/search',
                data: { keyword: word, abroad: abroad },
                Type: 'json',
                success: function(res){
                    res.all_ids.forEach(invisibleSpots);
		    res.display_ids.forEach(displaiedSpots);
                }
	       });
    });
});
