const initDropdownSelect = () => {
  // console.log("is this thing on?")
  const dropdownItems = document.querySelectorAll('.dropdown-item');

  dropdownItems.forEach((item) => {
    item.addEventListener('click', (event) => {
      dropdownItems.forEach((item) => item.classList.remove('active'));
      item.classList.toggle('active')
    });
  });

};

export { initDropdownSelect };

