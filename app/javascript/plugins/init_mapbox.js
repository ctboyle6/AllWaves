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
      // maxZoom: 1,
      center: [-80.6862, 28.3067]
    });

    let geolocate = new mapboxgl.GeolocateControl({
      fitBoundsOptions: {
       linear: true,
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
      const markersSaved = JSON.parse(mapElement.dataset.markerssaved);
      const markersNew = JSON.parse(mapElement.dataset.markersnew);
      console.log(markersNew);
      console.log(markersSaved);
      let markers = [];
      markersSaved.forEach((marker) => {
        // const popup = new mapboxgl.Popup().setHTML(marker.info_window);

        const element_saved = document.createElement('div');
        element_saved.className = 'marker-saved';
        element_saved.style.backgroundImage = `url('${marker.image_url}')`;
        element_saved.style.backgroundSize = 'contain';
        element_saved.style.width = '30px';
        element_saved.style.height = '30px';

        new mapboxgl.Marker(element_saved)
        .setLngLat([marker.lng, marker.lat])
        // .setPopup(popup)
        .addTo(map);
        markers.push({ lng: marker.lng, lat: marker.lat})

      });
      
      markersNew.forEach((marker) => {
        // const popup = new mapboxgl.Popup().setHTML(marker.info_window);

        const element_new = document.createElement('div');
        element_new.className = 'marker-saved';
        element_new.style.backgroundImage = `url('${marker.image_url}')`;
        element_new.style.backgroundSize = 'contain';
        element_new.style.width = '30px';
        element_new.style.height = '30px';

        new mapboxgl.Marker(element_new)
        .setLngLat([marker.lng, marker.lat])
        // .setPopup(popup)
        .addTo(map);
        markers.push({ lng: marker.lng, lat: marker.lat})
      });

      markers.push(userLocation._userLocationDotMarker._lngLat)
      fitMapToMarkersAndLocation(map, markers);
    }
    mapboxgl.clearStorage();
    getUserLocation();
    
  }
};

export { initMapbox };
