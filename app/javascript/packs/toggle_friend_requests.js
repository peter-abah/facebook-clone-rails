'use strict';

const toggleFriendRequests = function() {
  const friendRequestToggles = Array.from(document.querySelectorAll('.friend-requests-toggle'));
  const friendRequestTabs = Array.from(document.querySelectorAll('.friend-request-tab'))

  const toggleFriendRequestTab = (event) => {
    if (event.target.classList.contains('active-link')) return;

    friendRequestTabs.forEach(tab => { tab.classList.toggle('hidden') });
    friendRequestToggles.forEach(toggle => { toggle.classList.toggle('active-link') });
  };

  friendRequestToggles.forEach(toggle => { toggle.addEventListener('click', toggleFriendRequestTab) });
}();