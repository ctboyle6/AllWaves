const initFormtoggle = () => {
  const btn = document.getElementById('form-toggle');
  const form_items = document.querySelectorAll('.form-control')
  const form_ranges = document.querySelectorAll('.numeric.range')
  const form_save = document.getElementById('form-save');

  // console.log(form_ranges);
  // form_items[3].insertAdjacentHTML('beforebegin', '<span>kooook</span>')

  // form_ranges.forEach((range) => {
  //   const range_val = range.insertAdjacentHTML('beforebegin', `<span>${range.value}</span>`);
  //   range.addEventListener('input', () => {
  //     range.innerText = range.value;
  //   });
  // });


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
