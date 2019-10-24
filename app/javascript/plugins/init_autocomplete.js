import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('artist_city');
  if (addressInput) {
    places({
      container: addressInput
    });
  }
};

export {initAutocomplete};
