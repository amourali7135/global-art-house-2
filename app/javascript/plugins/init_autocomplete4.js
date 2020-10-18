import places from 'places.js';

const initAutocomplete4 = () => {
  const addressInput = document.getElementById('job_city');
  if (addressInput) {
    places({
      container: addressInput
    });
  }
};




export {initAutocomplete4};
