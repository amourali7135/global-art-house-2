import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('artist_city');
  if (addressInput) {
    places({
      container: addressInput
    });
  }
};


// const initAutocomplete = () => {
//   const addressInput = document.getElementById('artist_birth_place');
//   if (addressInput) {
//     places({
//       container: addressInput
//     });
//   }
// };



export {initAutocomplete};
