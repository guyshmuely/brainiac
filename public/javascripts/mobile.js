var jQT = new $.jQTouch({
  icon: '/images/client/apple-touch-icon.png',
  addGlossToIcon: true,
  startupScreen: "/images/client/apple-touch-startup.jpg",
  statusBar: 'default',
  formSelector: '.form',
  preloadImages: [
    '/images/client/jqtouch/themes/apple/activeBackButton.png',
    '/images/client/jqtouch/themes/apple/blueButton.png',
    '/images/client/jqtouch/themes/apple/grayButton.png',
    '/images/client/jqtouch/themes/apple/backButton.png',
    '/images/client/jqtouch/themes/apple/activeButton.png',
    '/images/client/jqtouch/themes/apple/pinstripes.png',
    '/images/client/jqtouch/themes/apple/toolButton.png',
    '/images/client/jqtouch/themes/apple/toolbar.png'
  ]
});

function selectBarLink(element) {
    $('div.bar a.selected').removeClass("selected");
    $(element).addClass("selected")
}

function activateScroller(id) {
        var scroller = $('div#' + id + ' div.scroller')[0];
        if (!$(scroller).hasClass('iscrollActive')) {
            $(scroller).addClass("iscrollActive")
            scroller.addEventListener('touchmove', function(e) {e.preventDefault();},false);
            var iscroll = new iScroll(scroller,{vScrollbar:true, checkDOMChanges:false});
            scroller.setAttribute('iscroll',iscroll);
            scroller.iscroll = iscroll
        }
        scroller.iscroll.refresh();
}

function calcDimention() {
//  jQuery('div#jqt').css('width',window.innerWidth);
  jQuery('div#jqt div.main').css('height',window.innerHeight-jQuery('div.bar').outerHeight() - jQuery('div.toolbar').outerHeight());
}

$(document).ready(function() {
//$(window).load(function() {
    activateScroller('home');
    calcDimention();
    $('body').bind('turn',calcDimention);

  jQuery('#account_new a.login').tap(function(e) {
    var $form = jQuery(this).closest('form');
    return app.login($form);
  });

  jQuery('#account_new').submit(function(e) {
    var $form = jQuery(this);
    return app.login($form);
  });

  jQuery('.signOutButton').tap(function(e) {
    return app.logout();
  });

  if (window.localStorage['current_account_email']) {
    jQuery('.signInButton').css('display', 'none');
    jQuery('.signOutButton').css('display', 'inline');
  } else {
    jQuery('.signInButton').css('display', 'inline');
    jQuery('.signOutButton').css('display', 'none');
  }
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
        if (info.direction=='in') {
            var $page = $(this);
            if ($page.data("loaded")) {
              return;
            }
            app.getCourses(function(req) {
                var $ul = $("#top ul:first");
                $ul.append(req.responseText);
                $('#top ul:first a').click(function(e) {
                    e.preventDefault();
                    jQT.tapHandler(e);
                    //this.tap();
                    //jqTouch.goTo();
                    //jQT.goTo(this.href,'slide');
                    return false
                });
                $page.data("loaded", true);
                activateScroller('top');
            });
        }
    })
    $('#categories').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') activateScroller('categories');
    })
    $('#search').bind('pageAnimationEnd',function(e,info) {
        if (info.direction=='in') activateScroller('search');
    })
})


var app = {

  logout: function() {

    $.ajax({
      type:'get', url:'/accounts/sign_out',
      complete:function (req) {
        if (req.status === 200 || req.status === 304) {
          window.localStorage.removeItem('authentication_token');
          window.localStorage.removeItem('current_account_email');
          jQuery('.signInButton').css('display', 'inline');
          jQuery('.signOutButton').css('display', 'none');
//          jQT.goTo('#home');
        } else {
          alert("There was an error logging out. Try again.");
        }
      }
    });

  },

  login: function($form) {

    $.ajax({
      type:$form.attr('method'), url:$form.attr('action'),
      dataType: 'json', data:$form.serialize(),
      complete:function (req) {
        if (req.status === 200 || req.status === 304) {
          window.localStorage['authentication_token']=jQuery(req.responseText).find('#authentication_token').html();
          window.localStorage['current_account_email']=jQuery(req.responseText).find('#current_account_email').html();
          jQuery('.signInButton').css('display', 'none');
          jQuery('.signOutButton').css('display', 'inline');
          jQT.goBack();
        } else {
          alert("There was an error logging in. Try again.");
        }
      }
    });

  },

  getCourses:function (f) {
    $.ajax({
      type:'get', url:'/courses', data:'',
      complete:function (req) {
        if (req.status === 200 || req.status === 304) {
          f(req)
        } else {
          alert("There was an error fetching courses");
        }
      }
    });
  }
};

$(function() {
  $(window.applicationCache).bind("error", function() {
    alert("There was an error when loading the cache manifest.");
  });
});

//window.onscroll = function() {
//  var element = jQuery('div.bar');
//   element.css('bottom','0px');
//};

function installCourse(link) {
  if (window.localStorage['current_account_email']) {
    window.open(link+'?auth_token='+window.localStorage['authentication_token']);
  } else {
    jQT.goTo('#sign_in','flipleft');
//    return false;
  }

}


