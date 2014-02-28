var validate = function(page_number,per_page){
    var lat       = $("input#latitude").val(),
        long      = $("input#longitude").val(),
        rad       = $("input#radius").val(),
        hash_tag  = $("input#hash_tag").val(),
        imageBox  = $('div#tweetTemplate ul.result-items').empty(),
        flag      = true;
    input_validate    = [$('span#lat-help'),$('span#lon-help'), $('span#rad-help')]
    $.each([lat,long,rad], function(i,e){
        if (e == "")
        {
            input_validate[i].addClass('font-red');
            flag = false;
        }
        else
        {
            input_validate[i].removeClass('font-red');
        }
    });

    if (flag)
    {
        renderTweets(lat,long,rad,hash_tag,page_number,per_page);
    }

};

var renderTweets = function(lat,long,rad,hash_tag,page_number,per_page) {
    var options   = {
        geo_location: [lat,long],
        radius:       rad,
        hash_tag:     hash_tag,
        page:         page_number,
        per_page:     per_page
    }
    _api      = "/tweets/retrieve_tweets",
        error     = $('div.controls p.help-block span#error').empty(),
        targetEle = $(document.body).find('#tweetTemplate ul.result-items');
    map.setCenter(new google.maps.LatLng(lat,long));
    $.ajax({
        type: "GET",
        url:  _api,
        data: options
    }).success(function(data) {
            showResult(data);
        });
};

var showResult = function(data){
    if(data.response.length == 0){
        clearOldMarkers();
        $("#no-result").show();
        $("#pagination_panel").hide();
    }
    else{
        $("#no-result").hide();
        showPagination(data.total,data.current_page);
        setMarkers(data.response);
    }
};


var showPagination = function(total, current){
    window.current = current;
    var panel = $("#pagination_panel");
    var pages = Math.ceil(total/20);
    panel.hide();
    if( pages > 0){
        panel.show();
        $("#total-pg").text(pages);
        $("#curr-pg").text(current);
        $("#prev-btn").show();
        $("#next-btn").show();
        if(current == 1){
            $("#prev-btn").hide();
        }
        if(current == pages){
            $("#next-btn").hide();
        }
        bindPaginationBtns();
    }
};

var bindPaginationBtns = function(){
  if(!window.binded){
      window.binded = 1;
      $("#prev-btn").bind('click', function(){
          validate(window.current-1,20);

      });
      $("#next-btn").bind('click', function(){
          validate(window.current+1,20);
      });
  }
};