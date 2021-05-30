const initFormtoggle = () => {
  const btn = document.getElementById('form-toggle');
  const form_items = document.querySelectorAll('.form-control')
  const form_ranges = document.querySelectorAll('.numeric.range')
  const form_save = document.getElementById('form-save');

  const render = (template, node) => {
    node.innerHTML = template;
  }

  // single range js added
  // const range_slide = document.getElementById('preference_swell_hgt_min');
  // range_slide.insertAdjacentHTML('afterend', '<p id=test2>TEST</p>');
  // range_slide.addEventListener('input', () => {
  //   let template = `<span>${range_slide.value}</span>`;
  //   render(template, document.querySelector('#test2'));
  // });

  form_ranges.forEach((range, index) => {
    range.insertAdjacentHTML('afterend', `<p id=range-val-insert-${index}></p>`);
    range.addEventListener('input', () => {
      let template = `<span>${range.value}</span>`;
      render(template, document.querySelector(`#range-val-insert-${index}`));
    });
  });


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
