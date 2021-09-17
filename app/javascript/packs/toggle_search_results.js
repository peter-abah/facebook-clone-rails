'use strict';

const toggleSearchRSesults = function() {
  const tabButtons = Array.from(document.querySelectorAll('.tab-button'));

  const usersSearchResult = document.querySelector('.search-result-users');
  const postsSearchResult = document.querySelector('.search-result-posts');

  const toggleTab = (event) => {
    if (event.target.classList.contains('active')) return;

    postsSearchResult.classList.toggle('hidden');
    usersSearchResult.classList.toggle('hidden');
    
    tabButtons.forEach(tabButton => { tabButton.classList.toggle('active') });
  };

  tabButtons.forEach(tabButton => { tabButton.addEventListener('click', toggleTab) });
}();