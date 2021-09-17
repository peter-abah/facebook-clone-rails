'use strict';

const sidebar = document.querySelector('.sidebar');

const hamburgerOpen = document.querySelector('.hamburger-open')
const hamburgerClose = document.querySelector('.hamburger-close')

hamburgerOpen.addEventListener('click', (event) => {
  sidebar.style.display = 'block';

  hamburgerOpen.style.display = 'none';
  hamburgerClose.style.display = 'inline';
});

hamburgerClose.addEventListener('click', (event) => {
  sidebar.style.display = 'none';

  hamburgerOpen.style.display = 'inline';
  hamburgerClose.style.display = 'none';
});