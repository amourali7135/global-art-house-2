import "bootstrap";
import {  initAutocomplete  } from "../plugins/init_autocomplete";
import { initMapbox } from '../plugins/init_mapbox';
import 'mapbox-gl/dist/mapbox-gl.css';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import $ from 'jquery';
// import select2 from 'select2';

// $(document).ready(function(){}); {
//   $('#select2-input select2-default').select2();
// }

initAutocomplete();
initMapbox();


