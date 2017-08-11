(function($){
  $(window).on("load",function(){
    $(".mcs-horizontal-example").mCustomScrollbar({
      axis:"x",
      theme:"dark-3",
      mouseWheel:{
        enable: true
      },
      scrollButtons:{
        enable: true
      },
      keyboard:{
        enable: true
      },
    });
  });
})(jQuery);
