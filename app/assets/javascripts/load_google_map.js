
function initialize() {
    var mapOptions = {
        zoom: 11,
        center: new google.maps.LatLng(37.4828,-122.2361)
    };
    map = new google.maps.Map(document.getElementById('map-canvas'),
                              mapOptions);
};

var base_map = function(){
    google.maps.event.addDomListener(window, 'load', initialize);
};

var setMarkers = function(tweets){
    window.old_markers = window.old_markers || [];
    clearOldMarkers();
    for(id in tweets) {
        var ele = "User: " +tweets[id].username + '<br>',
            ele = ele + "Tweet:      "   + tweets[id].tweet + '<br>',
            ele = ele + "Hash Tag:   "   + tweets[id].hash_tags + '<br>',
            ele = ele + "Location:   "   + tweets[id].location  + '<br>',
            ele = ele + "Tweeted on: "   + tweets[id].tweet_date  + '<br><br>';

        var loc = new google.maps.LatLng(tweets[id].location[0], tweets[id].location[1]);
        var marker_option ={
            position: loc,
            map: map,
            animation: google.maps.Animation.DROP,
            info: ele,
            loc: tweets[id].location + ''
        };
        var marker = new google.maps.Marker(marker_option);
        var infoWindow = new google.maps.InfoWindow({ maxWidth: 400, maxHeight: 400 });

        google.maps.event.addListener(marker, 'mouseover', function() {
            infoWindow.setContent(this.loc);
            infoWindow.open(map, this);
        });

        google.maps.event.addListener(marker, 'click', function() {
            infoWindow.setContent(this.info);
            infoWindow.open(map, this);
        });

        window.old_markers.push(marker)
    }
};

var clearOldMarkers = function(){
    for(id in window.old_markers){
        window.old_markers[id].setMap(null);
    }
};

var showResult = function(data){
    showPagination(data.total,data.current_page);
    setMarkers(data.response);
};
