const initFormtoggle = () => {
  const btn = document.getElementById('form-toggle');
  const form_items = document.querySelectorAll('.form-control')
  const form_ranges = document.querySelectorAll('.numeric.range')
  const form_save = document.getElementById('form-save');

  const render = (template, node) => {
    node.innerHTML = template;
  }


  // form_ranges.forEach((range) => {
  //   const range_val = range.insertAdjacentHTML('beforebegin', `<span>${range.value}</span>`);
  //   range.addEventListener('input', () => {
  //     range.innerText = range.value;
  //     range_val.innerText = range.value;
  //   });
  // });

  // console.log(document.querySelector('#test'));

  const range_slide = document.getElementById('preference_swell_hgt_min');
  range_slide.addEventListener('input', () => {
    let template = `<span>${range_slide.value}</span>`;
    render(template, document.querySelector('#test'));
  });
  // console.log(range_slide);


  if(btn) {
  btn.addEventListener('click', (event) => {
    event.preventDefault();

    form_items.forEach((item) => {
      item.toggleAttribute("disabled");
    });

    form_save.style.display = form_save.style.display === 'none' ? '' : 'none';
  })
}};


export { initFormtoggle };
