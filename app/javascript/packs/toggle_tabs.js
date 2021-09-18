'use strict';

const toggleTabs = function() {
  const tabButtons = Array.from(document.querySelectorAll('.tab-button'));
  const tabs = Array.from(document.querySelectorAll('.tab'))

  const toggleTab = (event) => {
    if (event.target.classList.contains('active')) return;

    tabs.forEach(tab => { tab.classList.toggle('hidden') });
    tabButtons.forEach(tabButton => { tabButton.classList.toggle('active') });
  };

  tabButtons.forEach(tabButton => { tabButton.addEventListener('click', toggleTab) });
}();