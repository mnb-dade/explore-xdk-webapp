$(function(){
  
  var source = new EventSource('/stream');
  
  source.addEventListener('stream.pictures.created', function(e) {
    var picture = $.parseJSON(e.data);
    
    if( ! $("img[data-id='"+ picture.id +"']").length ){
      var pictures = $('#pictures');
      var pic_div = $("<div class='col-xs-6 col-md-3' style='display: none;'></div>");
      var pic_link = $("<a href='"+ picture.image.url +"' class='thumbnail'></a>");
      var pic_img = $("<img src='"+ picture.image.url +"' data-id='"+ picture.id +"'>");
  
      pic_link.append(pic_img);
      pic_div.append(pic_link);
      pictures.prepend(pic_div);
  
      pic_div.fadeIn('slow');
    }
  });
  
  source.addEventListener('heartbeat', function(e) {
    console.log(e.data);
  });
  
});

