import DoubleSlider from 'double-slider';

const form_ranges = document.querySelectorAll('.c-src')
console.log(form_ranges);


// range slider display value
const render = (template, node) => {
  node.innerHTML = template;
}

const mySliderAction = () => {

  // Swell Sliders (3)
  // swell height
  const preferenceSwellHgtMin = document.getElementById('preference_swell_hgt_min');
  const preferenceSwellHgtMax = document.getElementById('preference_swell_hgt_max');

  const sliderSwellHgt = new DoubleSlider(document.getElementById('slider-swell-hgt'));
  sliderSwellHgt.addEventListener('slider:input', () => {
    const {min, max} = sliderSwellHgt.value;
    console.log(`Min is: ${min}, max is: ${max}`);
    preferenceSwellHgtMin.value = min;
    preferenceSwellHgtMax.value = max;
  });

  // swell interval
  const preferenceSwellIntMin = document.getElementById('preference_swell_int_min');
  const preferenceSwellIntMax = document.getElementById('preference_swell_int_max');

  const sliderSwellInt = new DoubleSlider(document.getElementById('slider-swell-int'));
  sliderSwellInt.addEventListener('slider:input', () => {
    const {min, max} = sliderSwellInt.value;
    console.log(`Min is: ${min}, max is: ${max}`);
    preferenceSwellIntMin.value = min;
    preferenceSwellIntMax.value = max;
  });

  // swell direction
  const preferenceSwellDirMin = document.getElementById('preference_swell_dir_min');
  const preferenceSwellDirMax = document.getElementById('preference_swell_dir_max');

  const sliderSwellDir = new DoubleSlider(document.getElementById('slider-swell-dir'));
  sliderSwellDir.addEventListener('slider:input', () => {
    const {min, max} = sliderSwellDir.value;
    console.log(`Min is: ${min}, max is: ${max}`);
    preferenceSwellDirMin.value = min;
    preferenceSwellDirMax.value = max;
  });

  // Wind Sliders (2)
  // Wind strength
  const preferenceWindStrMin = document.getElementById('preference_wind_str_min');
  const preferenceWindStrMax = document.getElementById('preference_wind_str_max');

  const sliderWindStr = new DoubleSlider(document.getElementById('slider-wind-str'));
  sliderWindStr.addEventListener('slider:input', () => {
    const {min, max} = sliderWindStr.value;
    console.log(`Min is: ${min}, max is: ${max}`);
    preferenceWindStrMin.value = min;
    preferenceWindStrMax.value = max;
  });

  // Wind direction
  const preferenceWindDirMin = document.getElementById('preference_wind_dir_min');
  const preferenceWindDirMax = document.getElementById('preference_wind_dir_max');

  const sliderWindDir = new DoubleSlider(document.getElementById('slider-wind-dir'));
  sliderWindDir.addEventListener('slider:input', () => {
    const {min, max} = sliderWindDir.value;
    console.log(`Min is: ${min}, max is: ${max}`);
    preferenceWindDirMin.value = min;
    preferenceWindDirMax.value = max;
  });

}

export { mySliderAction };
