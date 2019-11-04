import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const mapElement = document.getElementById('map');

// [...]
// if (mapElement) {
//   // [...]
//   map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken }));
// }

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup) // add this
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const mapClicking = map => {
  map.on('click', (e) => {
    const features = map.queryRenderedFeatures(e.point, {
      layers: ['states-layer']
    });
    if (!features.length) {
      return;
    }

    const feature = features[0];
    // ES6
    const { iso_a2, name } = feature.properties;
    // ES6 or everything
    // const iso_a2 = feature.properties.iso_a2;
    // const name = feature.properties.name;

    new mapboxgl.Popup()
      .setLngLat(map.unproject(e.point))
      .setHTML(`<a href="http://localhost:3000/artists/?utf8=✓&search%5Btag_ids%5D%5B%5D=&search%5Bcountry%5D=${iso_a2}&search%5Bcity%5D=&commit=Submit">See the artists in ${name}!</a>`)
      .addTo(map);
  });
};

const addGeoJson = map => {
  map.on('load', () => {
    map.addSource('states', {
      'type': 'geojson',
      'data': 'https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_50m_admin_0_countries.geojson'
    });
  })
}

const addLayerToMap = map => {
  map.on('load', () => {
    map.addLayer({
      'id': 'states-layer',
      'type': 'fill',
      'source': 'states',
      'paint': {
        'fill-color': 'rgba(200, 100, 240, 0.4)',
        'fill-outline-color': 'rgba(200, 100, 240, 1)'
      }
    });
  })
}

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    addGeoJson(map);
    addLayerToMap(map);
    mapClicking(map);
  }
};

export { initMapbox };
