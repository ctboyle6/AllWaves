import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const fitMapToMarkersAndLocation = (map, markers) => {
  const  bounds = new mapboxgl.LngLatBounds();
  // bounds.extend(["", ""]);
  // markers.forEach(marker => console.log([marker.lng, marker.lat]));
  // bounds = markers.reduce(function (bounds, coord) {
  //   return bounds.extend(coord);
  // }, new mapboxgl.LngLatBounds(markers[0], markers[0]));

  debugger
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { 
    padding: 80,
    duration: 500,
  });
  console.log(bounds);
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/clay-land/ckp5osrj83shf17moirgdc925'
    });

    let geolocate = new mapboxgl.GeolocateControl({
      fitBoundsOptions: {
       linear: true,
       minZoom: 10
      },
      positionOptions: {
        enableHighAccuracy: false
      },
      trackUserLocation: false
    });
    
    // map.addControl(geolocate);
    // map.on('load', function () {
    //   geolocate.trigger();
    // });

    
    function sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    }

    async function getUserLocation() {
      // const userLocation = geolocate.on('geolocate');
      // debugger
      await sleep(3000);
      const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window);
        new mapboxgl.Marker()
          .setLngLat([marker.lng, marker.lat])
          .setPopup(popup)
          .addTo(map);
      });
      // markers.push(userLocation._userLocationDotMarker._lngLat)
      console.log(markers)
      await sleep(3000);
      fitMapToMarkersAndLocation(map, markers);
    }

    getUserLocation();
    
  }
};

export { initMapbox };
