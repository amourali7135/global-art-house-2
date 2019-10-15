import "bootstrap";
import {  initAutocomplete  } from "../plugins/init_autocomplete";
import { initMapbox } from '../plugins/init_mapbox';
import 'mapbox-gl/dist/mapbox-gl.css';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import $ from 'jquery';
import { initCarousel } from '../plugins/init_carousel';


initAutocomplete();
initMapbox();
initCarousel();
// initOwl();
