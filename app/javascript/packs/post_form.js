'use strict';

const showImages = (event) => {
  console.log('www')
  imagesDiv.innerHTML = '';

  for (let file of event.target.files) {
    const image = document.createElement('img');
    image.className = 'uploaded-image';

    image.src = URL.createObjectURL(file);
    imagesDiv.appendChild(image);
  }
};

const imageInput = document.querySelector('.image-input');
const imagesDiv = document.querySelector('.post-form-images');
console.log('in')
imageInput.addEventListener('change', showImages);
console.log('0ut')