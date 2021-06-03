const addActiveClass = (event) => {
  if (document.querySelector('.day.active-day') !== null) {
    document.querySelector('.day.active-day').classList.remove('active-day');
  }
  event.currentTarget.classList.add("active-day");
}

const initActiveDay = () => {
  const days = document.querySelectorAll('.day')
  days.forEach((day) => {
    day.addEventListener('click', addActiveClass)
  });
}

export { initActiveDay };
