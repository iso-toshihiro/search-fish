$(document).ready(function(){
    function displaiedFish(value) {
	var element =  document.getElementById("fish_id_" + value );
	element.style.display = 'block';
    }

    function invisibleFish(value) {
	var element =  document.getElementById("fish_id_" + value );
	element.style.display = 'none';
    }

    $('#group_box').change(function() {
	spotId = $(this).attr('spot_id');
	group = $("select option:selected").text();
	alert(spotId);
	$.ajax({type: 'GET',
		url:  '/diving_spots/' + spotId + '/fishes/group',
		data: {id: spotId, group: group},
		sataType: 'json',
		success: function(res){
		    res.all_ids.forEach(invisibleFish);
		    res.display_ids.forEach(displaiedFish);
		}
	       });
    });
});
