'use strict';

const showProfileFormImages = function() { 
  const showImage = (event, imageElement) => {
    const file = event.target.files[0]
    imageElement.src = URL.createObjectURL(file);
  };

  const profilePicInput = document.querySelector('.profile-pic-input');
  const coverImageInput = document.querySelector('.cover-image-input');
  
  const profilePic = document.querySelector('.edit-profile-image img')
  const coverImage = document.querySelector('.edit-cover-image img')

  profilePicInput.addEventListener('change', (event) => { showImage(event, profilePic) });
  coverImageInput.addEventListener('change', (event) => { showImage(event, coverImage) });
}();