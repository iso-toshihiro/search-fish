function attachMessage(marker, spot, openSwitch) {
    var windowId = 'spot_marker_window_' + spot.id;
    var url = '/diving_spots/' + spot.id  + '/fishes';
    var html = '<a href="' + url + '" id="' + windowId + '" window="open">'+ spot.name + '</a>';

    var infoWindow = new google.maps.InfoWindow({
	Content: html
    });

    google.maps.event.addListener(marker, 'click', function(event){
	if ( $('#' + windowId).attr('window') != 'open') {
	    infoWindow.open(marker.getMap(), marker);
	}
    });

    if(openSwitch) {
	infoWindow.open(marker.getMap(), marker);
    }
}

function mapInitialize() {
    var first_position = new google.maps.LatLng(35.6809691281986,139.7668620944023);
    mapSet(first_position, 5, null);
};

function mapSet(centerPosition, zoomLevel, openId) {
    var opts = {
	zoom: zoomLevel,
	center: centerPosition,
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
		    var markerPosition = new google.maps.LatLng(res.spots[i].lat, res.spots[i].lng);
		    var marker = new google.maps.Marker({
			position: markerPosition,
			map: map,
			title: res.spots[i].name
		    });
		    var open = (openId == res.spots[i].id) ? true : false ;
		    attachMessage(marker, res.spots[i], open);
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

    function spotSearch() {
	var abroad = $("select option:selected").val();
	var word = $('#spot_search').val();
        $.ajax({type: 'GET',
		url:  '/diving_spots/search',
                data: { keyword: word, abroad: abroad },
                Type: 'json',
                success: function(res){
                    res.all_ids.forEach(invisibleSpots);
		    res.display_ids.forEach(displaiedSpots);
                }
	       });
    }

    $('#spot_search').change(spotSearch);

    $('#abroad_select_box').change(spotSearch);

    $('.indicating_on_map').click(function() {
	var spotId = $(this).attr('spot_id');
	$.ajax({type: 'GET',
		url:  '/diving_spots/' + spotId + '/position',
		Type: 'json',
		success: function(res){
		    var position = new google.maps.LatLng(res.lat, res.lng);
		    mapSet(position, 10, res.id);
		}
	       });
    });
});
