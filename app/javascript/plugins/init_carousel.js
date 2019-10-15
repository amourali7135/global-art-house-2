import "bootstrap";

const initCarousel = () => {
  $( document ).ready(function(){
    $('#my-carousel').carousel();
  });
}
export { initCarousel };