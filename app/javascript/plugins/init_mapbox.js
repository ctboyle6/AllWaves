import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const fitMapToMarkersAndLocation = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/clay-land/ckp5osrj83shf17moirgdc925'
    });

    let geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      trackUserLocation: false
    });
    
    map.addControl(geolocate);
    map.on('load', function () {
      geolocate.trigger();
    });
  
    geolocate.on('geolocate', function (e) {
      const lon = e.coords.longitude;
      const lat = e.coords.latitude;
      const location = [lon , lat]
      console.log("Position ok");
    })
    const markers = JSON.parse(mapElement.dataset.markers);

    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
    
    fitMapToMarkersAndLocation(map, markers);
  }
};

export { initMapbox };
