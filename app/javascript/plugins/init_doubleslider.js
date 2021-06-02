import DoubleSlider from 'double-slider';


// range slider display value
const render = (template, node) => {
  node.innerHTML = template;
}

const doubleSliderAction = () => {

  // Swell Sliders (3)
  // swell height
  const preferenceSwellHgtMin = document.getElementById('preference_swell_hgt_min');
  const preferenceSwellHgtMax = document.getElementById('preference_swell_hgt_max');
  const valueSwellHgtMin = document.getElementById('value-swell-hgt-min');
  const valueSwellHgtMax = document.getElementById('value-swell-hgt-max');

  if(!preferenceSwellHgtMin) return

  const sliderSwellHgt = new DoubleSlider(document.getElementById('slider-swell-hgt'));
  sliderSwellHgt.addEventListener('slider:input', () => {
    const {min, max} = sliderSwellHgt.value;
    preferenceSwellHgtMin.value = min;
    preferenceSwellHgtMax.value = max;
    valueSwellHgtMin.innerText = `Min: ${min}`;
    valueSwellHgtMax.innerText = `Max: ${max}`;
  });


  // swell interval
  const preferenceSwellIntMin = document.getElementById('preference_swell_int_min');
  const preferenceSwellIntMax = document.getElementById('preference_swell_int_max');
  const valueSwellIntMin = document.getElementById('value-swell-int-min');
  const valueSwellIntMax = document.getElementById('value-swell-int-max');

  const sliderSwellInt = new DoubleSlider(document.getElementById('slider-swell-int'));
  sliderSwellInt.addEventListener('slider:input', () => {
    const {min, max} = sliderSwellInt.value;
    preferenceSwellIntMin.value = min;
    preferenceSwellIntMax.value = max;
    valueSwellIntMin.innerText = `Min: ${min}`;
    valueSwellIntMax.innerText = `Max: ${max}`;
  });


  // swell direction
  const preferenceSwellDirMin = document.getElementById('preference_swell_dir_min');
  const preferenceSwellDirMax = document.getElementById('preference_swell_dir_max');
  const valueSwellDirMin = document.getElementById('value-swell-dir-min');
  const valueSwellDirMax = document.getElementById('value-swell-dir-max');

  const sliderSwellDir = new DoubleSlider(document.getElementById('slider-swell-dir'));
  sliderSwellDir.addEventListener('slider:input', () => {
    const {min, max} = sliderSwellDir.value;
    preferenceSwellDirMin.value = min;
    preferenceSwellDirMax.value = max;
    valueSwellDirMin.innerText = `Min: ${min}`;
    valueSwellDirMax.innerText = `Max: ${max}`;
  });


  // Wind Sliders (2)
  // Wind strength
  const preferenceWindStrMin = document.getElementById('preference_wind_str_min');
  const preferenceWindStrMax = document.getElementById('preference_wind_str_max');
  const valueWindStrMin = document.getElementById('value-wind-str-min');
  const valueWindStrMax = document.getElementById('value-wind-str-max');

  const sliderWindStr = new DoubleSlider(document.getElementById('slider-wind-str'));
  sliderWindStr.addEventListener('slider:input', () => {
    const {min, max} = sliderWindStr.value;
    preferenceWindStrMin.value = min;
    preferenceWindStrMax.value = max;
    valueWindStrMin.innerText = `Min: ${min}`;
    valueWindStrMax.innerText = `Max: ${max}`;
  });


  // Wind direction
  const preferenceWindDirMin = document.getElementById('preference_wind_dir_min');
  const preferenceWindDirMax = document.getElementById('preference_wind_dir_max');
  const valueWindDirMin = document.getElementById('value-wind-dir-min');
  const valueWindDirMax = document.getElementById('value-wind-dir-max');

  const sliderWindDir = new DoubleSlider(document.getElementById('slider-wind-dir'));
  sliderWindDir.addEventListener('slider:input', () => {
    const {min, max} = sliderWindDir.value;
    preferenceWindDirMin.value = min;
    preferenceWindDirMax.value = max;
    valueWindDirMin.innerText = `Min: ${min}`;
    valueWindDirMax.innerText = `Max: ${max}`;
  });
}

export { doubleSliderAction };
