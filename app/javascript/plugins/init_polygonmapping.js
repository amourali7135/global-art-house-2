import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

map.on('load', function () {
// Add a layer showing the state polygons.
map.addLayer({
'id': 'states-layer',
'type': 'fill',
'source': {
'type': 'geojson',
'data': 'https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_110m_admin_1_states_provinces_shp.geojson'
},
'paint': {
'fill-color': 'rgba(200, 100, 240, 0.4)',
'fill-outline-color': 'rgba(200, 100, 240, 1)'
}
});
 
// When a click event occurs on a feature in the states layer, open a popup at the
// location of the click, with description HTML from its properties.
map.on('click', 'states-layer', function (e) {
new mapboxgl.Popup()
.setLngLat(e.lngLat)
.setHTML(e.features[0].properties.name)
.addTo(map);
});
 
// Change the cursor to a pointer when the mouse is over the states layer.
map.on('mouseenter', 'states-layer', function () {
map.getCanvas().style.cursor = 'pointer';
});
 
// Change it back to a pointer when it leaves.
map.on('mouseleave', 'states-layer', function () {
map.getCanvas().style.cursor = '';
});
});

// export { initPolygonMapping };