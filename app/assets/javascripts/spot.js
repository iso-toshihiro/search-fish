function attachMessage(marker, spot, openSwitch) {
    var windowId = 'spot_marker_window_' + spot.id;
    var infoWindow = new google.maps.InfoWindow({
	Content: spot.html
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
    var first_position = new google.maps.LatLng(35.0809691281986,135.2668620944023);
    mapSet(first_position, 6, null);
};

function mapSet(centerPosition, zoomLevel, openId) {
    var opts = {
	zoom: zoomLevel,
	center: centerPosition,
	mapTypeId: google.maps.MapTypeId.ROADMAP,
	streetViewControl: false
    };
    var map = new google.maps.Map(document.getElementById("map_canvas"), opts);

    $.ajax({type: 'GET',
	    url:  '/diving_spots/information',
	    Type: 'json',
	    success: function(res){
		for( var i = 0 ; i < res.spots.length; i++) {
		    if( !res.spots[i].latitude ) {
			continue;
		    }
		    var markerPosition = new google.maps.LatLng(res.spots[i].latitude, res.spots[i].longitude);

		    var marker = new google.maps.Marker({
			icon: 'http://maps.google.co.jp/mapfiles/ms/icons/marina.png',
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
	var element = document.getElementById("spot_id_" + value );
	element.style.display = 'block';
    }

    function invisibleSpots(value) {
        var element = document.getElementById("spot_id_" + value );
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
		    var numberOfLine = Math.ceil(res.display_ids.length / 3);
		    var spotListHeight = numberOfLine * 30;
		    document.getElementById('spot_list').style.height = String(spotListHeight) + 'px';
                }
	       });
    }

    $('#spot_search').keyup(spotSearch);

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
