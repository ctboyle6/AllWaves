const initFormtoggle = () => {
  const btn = document.getElementById('form-toggle');
  const form_items = document.querySelectorAll('.form-control')

  if(btn) {
  btn.addEventListener('click', (event) => {
    event.preventDefault();

    form_items.forEach((item) => {
      item.toggleAttribute("disabled");
    })
  })
}};


export { initFormtoggle };
