var jQT = new $.jQTouch({
  icon: icon_path,
  addGlossToIcon: true,
  //startupScreen: "/images/client/apple-touch-startup.jpg",
  statusBar: 'default',
  formSelector: '.form',
  preloadImages: [
      '/images/client/jqtouch/themes/apple/redButton.png',
      '/images/client/jqtouch/themes/apple/whiteButton.png',
      '/images/client/jqtouch/themes/apple/activeBackButton.png',
      '/images/client/jqtouch/themes/apple/backButton.png',
      '/images/client/jqtouch/themes/apple/activeButton.png',
      '/images/client/jqtouch/themes/apple/pinstripes.png',
      '/images/client/jqtouch/themes/apple/toolButton.png',
      '/images/client/jqtouch/themes/apple/toolbar.png',
  ]
});

function setCard(id) {
    if (app.data.length > 0) {
      var c = $('div#' + id + ' div.content');
      alert(app.data)
      alert(app.data[Math.floor(Math.random()*app.data.length)])
      content = app.data[Math.floor(Math.random()*app.data.length)].card.content;
      c.html(content);
    }
}

jQuery(function() {
    $('#home').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') setCard('card_a');
    })
    $('#card_a').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') setCard('card_b');
    })    
    $('#card_b').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') setCard('card_a');
    })
})


var app = {

  data: [],

  getData:function (f) {
    $.retrieveJSON('/client/courses/' + course_id + '/data.json' , function(data) {
      f(data);
    });

//    $.ajax({
//      type:'get', url:'/client/courses/' + course_id, data:'',
//      complete:function (req) {
//        if (req.status === 200 || req.status === 304) {
//          f(req)
//        } else {
//          alert("There was an error fetching course");
//        }
//      }
//    });
  }
};

$(window).load(function() {
    app.getData(function(data) {        
        app.data = data;
    })
});



//var appCache = window.applicationCache;
//
//switch (appCache.status) {
//  case appCache.UNCACHED: // UNCACHED == 0
//    return 'UNCACHED';
//    break;
//  case appCache.IDLE: // IDLE == 1
//    return 'IDLE';
//    break;
//  case appCache.CHECKING: // CHECKING == 2
//    return 'CHECKING';
//    break;
//  case appCache.DOWNLOADING: // DOWNLOADING == 3
//    return 'DOWNLOADING';
//    break;
//  case appCache.UPDATEREADY:  // UPDATEREADY == 5
//    return 'UPDATEREADY';
//    break;
//  case appCache.OBSOLETE: // OBSOLETE == 5
//    return 'OBSOLETE';
//    break;
//  default:
//    return 'UKNOWN CACHE STATUS';
//    break;
//};
//
//var appCache = window.applicationCache;
//
//appCache.update(); // Attempt to update the user's cache.
//
//...
//
//if (appCache.status == window.applicationCache.UPDATEREADY) {
//  appCache.swapCache();  // The fetch was successful, swap in the new cache.
//}


google.bookmarkbubble.Bubble.prototype.NUMBER_OF_TIMES_TO_DISMISS = 4;
google.bookmarkbubble.Bubble.prototype.LOCAL_STORAGE_PREFIX = 'BOOKMARK_COURSE_' + course_id;
google.bookmarkbubble.Bubble.prototype.iconUrl_ = icon_path

$(window).load(function() {
  window.setTimeout(function() {
    var bubble = new google.bookmarkbubble.Bubble();

    var parameter = 'bmb=1';

    bubble.hasHashParameter = function() {
      return window.location.hash.indexOf(parameter) != -1;
    };

    bubble.setHashParameter = function() {
      if (!this.hasHashParameter()) {
        window.location.hash += parameter;
      }
    };

    bubble.getViewportHeight = function() {
      window.console.log('Example of how to override getViewportHeight.');
      return window.innerHeight;
    };

    bubble.getViewportScrollY = function() {
      window.console.log('Example of how to override getViewportScrollY.');
      return window.pageYOffset;
    };

    bubble.registerScrollHandler = function(handler) {
      window.console.log('Example of how to override registerScrollHandler.');
      window.addEventListener('scroll', handler, false);
    };

    bubble.deregisterScrollHandler = function(handler) {
      window.console.log('Example of how to override deregisterScrollHandler.');
      window.removeEventListener('scroll', handler, false);
    };

    bubble.showIfAllowed();
  }, 1000);
});