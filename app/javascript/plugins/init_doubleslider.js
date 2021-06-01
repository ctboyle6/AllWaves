import DoubleSlider from 'double-slider';

const mySliderAction = () => {
  const preferenceSwellHgtMin = document.getElementById('preference_swell_hgt_min');
  const preferenceSwellHgtMax = document.getElementById('preference_swell_hgt_max');

  const mySlider = new DoubleSlider(document.getElementById('my-slider'));
  mySlider.addEventListener('slider:change', () => {
    const {min, max} = mySlider.value;
    console.log(`Min is: ${min}, max is: ${max}`);
    preferenceSwellHgtMin.value = min;
    preferenceSwellHgtMax.value = max;
  });
}

export { mySliderAction };
