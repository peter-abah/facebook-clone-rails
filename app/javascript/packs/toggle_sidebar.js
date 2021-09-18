'use strict';

const toggleSidebar = function() {
  const sidebar = document.querySelector('.sidebar');

  const hamburgerButton = document.querySelector('.hamburger');
  const hamburgericons = Array.from(document.querySelectorAll('.hamburger-icon'));

  hamburgerButton.addEventListener('click', (event) => {
    sidebar.classList.toggle('visible');

    hamburgericons.forEach(button => { button.classList.toggle('hidden') })
  });

}();