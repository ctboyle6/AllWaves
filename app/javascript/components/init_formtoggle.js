const initFormtoggle = () => {
  const btn = document.getElementById('form-toggle');
  const form_items = document.querySelectorAll('.form-control')
  const form_ranges = document.querySelectorAll('.numeric.range')
  const form_save = document.getElementById('form-save');

  // range slider display value
  const render = (template, node) => {
    node.innerHTML = template;
  }

  form_ranges.forEach((range, index) => {
    range.insertAdjacentHTML('afterend', `<p id=range-val-insert-${index}>${range.value}</p>`);
    range.addEventListener('input', () => {
      let template = `<span>${range.value}</span>`;
      render(template, document.querySelector(`#range-val-insert-${index}`));
    });
  });


  // lock/unlock form
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
