// TODO: Write your JS code in here
const initWeather = () => {
  const apiKey = "3cc1136953500e619f88e19a9a56b51b";
  const city = document.getElementById("city");
  const weekday = document.getElementById("weekday");
  const month = document.getElementById("month");
  const desc = document.getElementById("desc");
  const icon = document.getElementById("weather-icon");
  const temp = document.getElementById("temp");


  const createUrl = () => {
    return `https://api.openweathermap.org/data/2.5/weather?q=${city.dataset.location}&units=metric&appid=${apiKey}`;
  };

  const iconUrl = (code) => {
    return `http://openweathermap.org/img/wn/${code}@2x.png`;
  };

  const injectValues = (data) => {
    city.innerText = data.name;
    weekday.innerText = weekday.dataset.dateWeekday;
    month.innerText = month.dataset.dateMonth;
    desc.innerText = data.weather[0].description.replace(/\b\w/g, l => l.toUpperCase());
    icon.src = iconUrl(data.weather[0].icon);
    temp.innerText = `${Math.round(Number.parseInt(data.main.temp, 10))}`;
  };
  if (city) {
    fetch(createUrl())
      .then(response => response.json())
      .then((data) => {
        injectValues(data);
      });
  }
};

export { initWeather };
