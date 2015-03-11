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

	$.ajax({type: 'GET',
		url:  '/diving_spots/' + spotId + '/fishes/group',
		data: {id: spotId, group: group},
		sataType: 'json',
		success: function(res){
		    res.all_ids.forEach(invisibleFish);
		    res.display_ids.forEach(displaiedFish);
		    var numberOfLine = Math.ceil(res.display_ids.length / 3);
		    var fishListHeight = numberOfLine * 220 + 97;
		    document.getElementById('fish_list').style.height = String(fishListHeight) + 'px';
		}
	       });
    });

    $('img').error(function() {
	var fishId = $(this).attr('fish_id');
	$.ajax({type: 'GET',
		url:  '/diving_spots/' + fishId + '/fish/another_url',
		data: {id: fishId},
		sataType: 'json',
		success: function(res){
		    $('#fish_picture_'+ res.id).attr('src', res.url);
		}
	       });
    });
});
