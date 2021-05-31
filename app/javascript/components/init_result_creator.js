
const compileResults = (spot, preference) => {
  // console.log(typeof(spot))
  fetch(`/result/spots/${spot}?preference_id=${preference}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => {
      console.log(data.result);
      // buildingFunction(partial, result)
          // insertingHTML(partial)
    });
};


const initResultCreator = () => {
  const spot = document.getElementById('spot-dropdown')
  const preference = document.getElementById('preference-dropdown')
  const form = document.getElementById('dashboard-result')

  form.addEventListener( 'submit', (event) =>{
    event.preventDefault();
    console.log(Rails)
    compileResults(spot.value, preference.value);

  });

  // spot.addEventListener( 'input', () =>{
  //   preference.insertAdjacentHTML('afterend', "<p>spot change</p>")
  // });
  //   preference.addEventListener( 'input', () =>{
  //   preference.insertAdjacentHTML('afterend', "<p>pref change</p>")
  // });

};


export { initResultCreator };
