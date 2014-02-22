
function initialize() {
    var mapOptions = {
        zoom: 11,
        center: new google.maps.LatLng(37.4828,-122.2361)
    };
    map = new google.maps.Map(document.getElementById('map-canvas'),
                              mapOptions);
}


base_map = function(){
    google.maps.event.addDomListener(window, 'load', initialize);
}