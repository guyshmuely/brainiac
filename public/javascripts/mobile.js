var jQT = new $.jQTouch({
  icon: '/images/client/apple-touch-icon.png',
  //addGlossToIcon: false,
  startupScreen: "/images/client/apple-touch-startup.jpg",
  statusBar: 'default',
  formSelector: '.form',
  preloadImages: [
    '/images/client/jqtouch/themes/apple/activeBackButton.png',
    '/images/client/jqtouch/themes/apple/backButton.png',
    '/images/client/jqtouch/themes/apple/activeButton.png',
    '/images/client/jqtouch/themes/apple/pinstripes.png',
    '/images/client/jqtouch/themes/apple/toolButton.png',
    '/images/client/jqtouch/themes/apple/toolbar.png',
  ]
});

function selectBarLink(element) {
    $('div.bar a.selected').removeClass("selected");
    $(element).addClass("selected")
}

function activateScroller(id) {    
        var scroller = $('#' + id + ' div.scroller')[0];
        if (!$(scroller).hasClass('iscrollActive')) {
            $(scroller).addClass("iscrollActive")
            scroller.addEventListener('touchmove', function(e) {e.preventDefault();},false);
            var iscroll = new iScroll(scroller,{vScrollbar:true, checkDOMChanges:false});
            scroller.setAttribute('iscroll',iscroll);
            scroller.iscroll = iscroll
        }
        scroller.iscroll.refresh();
}

$(window).load(function() {    
    activateScroller('home');
});

if (window.navigator.standalone) {
   //alert ('Thanks for launching this app your home screen')
} else {
   alert('Add this app to your home screen for the best experience.')
}

jQuery(function() {
    $('#about').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') activateScroller('about');
    })
    $('#home').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') activateScroller('home');
    })
    $('#top').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') activateScroller('top');
    })
    $('#categories').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') activateScroller('categories');
    })
    $('#search').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') activateScroller('search');
    })
})

