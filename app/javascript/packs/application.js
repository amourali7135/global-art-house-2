import "bootstrap";
import {  initAutocomplete  } from "../plugins/init_autocomplete";
import $ from 'jquery';
import 'select2';
import { initMapbox } from '../plugins/init_mapbox';
import 'mapbox-gl/dist/mapbox-gl.css';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';


// $('#city-input').select2();

initAutocomplete();
initMapbox();


// document.addEventListener('DOMContentLoaded', function() {
//   console.log('hehe')
//   return CountryStateSelect({
//     country_id: "artist_country",
//     state_id: "artist_state"
//   });
// })

// $(document).on('ready', function () {
//   console.log('ready')
//   return CountryStateSelect({
//     country_id: "artist_country",
//     state_id: "artist_state"
//   });
// });
