import "bootstrap";
import {  initAutocomplete  } from "../plugins/init_autocomplete";
import {  initAutocomplete2  } from "../plugins/init_autocomplete2";
import {  initAutocomplete3  } from "../plugins/init_autocomplete3";
import { initMapbox } from '../plugins/init_mapbox';
import 'mapbox-gl/dist/mapbox-gl.css';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import $ from 'jquery';
// import { initCarousel } from '../plugins/init_carousel';
import { initSelect2 } from '../plugins/init_select2';


initAutocomplete();
initAutocomplete2();
initAutocomplete3();
initMapbox();
initSelect2();
// initCarousel();


