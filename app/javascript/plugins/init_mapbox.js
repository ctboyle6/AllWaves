import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const fitMapToMarkersAndLocation = (map, markers) => {
  const  bounds = new mapboxgl.LngLatBounds();

  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));


  map.fitBounds(bounds, { 
    padding: 80,
    duration: 500,
  });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');  
  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/satellite-streets-v11',
      center: [-80.6862, 28.3067]
    });

    let geolocate = new mapboxgl.GeolocateControl({
      fitBoundsOptions: {
       linear: true,
       minZoom: 1,
       maxZoom: 1,
      center: [-80.6862, 28.3067]
      },
      positionOptions: {
        enableHighAccuracy: false
      },
      trackUserLocation: false
    });
    map.addControl(geolocate);
    map.on('load', function () {
      geolocate.trigger();
    });
    
    function sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    }
    
    async function getUserLocation() {
      
      const userLocation = geolocate.on('geolocate');
      await sleep(3000);
      const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window);
        new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
      });
      markers.push(userLocation._userLocationDotMarker._lngLat)
      fitMapToMarkersAndLocation(map, markers);
    }
    
    getUserLocation();
    
  }
};

export { initMapbox };
