const initFormtoggle = () => {
  const btn = document.getElementById('form-toggle');
  const form_items = document.querySelectorAll('.form-control')
  const form_save = document.getElementById('form-save');

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
