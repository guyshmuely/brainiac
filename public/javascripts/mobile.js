var jQT = new $.jQTouch({
  icon: '/images/client/brainiac_icon.png',
  //addGlossToIcon: false,
  startupScreen: "/images/client/brainiac_startup.jpg",
  statusBar: 'default',
  formSelector: '.form',
  preloadImages: [
    '/images/client/jqtouch/themes/apple/backButton.png',
    '/images/client/jqtouch/themes/apple/activeButton.png',
    '/images/client/jqtouch/themes/apple/pinstripes.png',
    '/images/client/jqtouch/themes/apple/toolButton.png',
    '/images/client/jqtouch/themes/apple/toolBar.png',
    '/images/client/under_construction.png',
    '/images/client/hagit.png',
    '/images/client/guy.png',
    '/images/client/sagi.png'
  ]
});

if (window.navigator.standalone) {
   //alert ('Thanks for launching this app your home screen')
} else {

   //alert('Add this app to your home screen for the best experience')
} 