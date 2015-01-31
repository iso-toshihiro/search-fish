$(document).ready(function(){
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
		url: '/diving_spots/search',
                data: { keyword: word },
                Type: 'json',
                success: function(res){
                    res.all_ids.forEach(invisibleSpots);
		    res.display_ids.forEach(displaiedSpots);
                }
	       });
    });
});
