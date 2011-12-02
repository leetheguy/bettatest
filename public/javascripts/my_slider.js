$(document).ready(function(){
  $('#block').oSlider({
    autoStart: true,
    pauseOnHover: true,
    arrowsNavHide: true,
    pauseTime: 7000,
    animSpeed: 3000,
    layers: {
      first: {
        className: 'layer-one',
        offset: 10,
        direction: 'ltr'
      },
      second: {
        className: 'layer-two',
        offset: 20,
        direction: 'ltr'
      },
      third: {
        className: 'layer-three',
        offset: 30,
        direction: 'ltr'
      }
    }
  });
}); 
