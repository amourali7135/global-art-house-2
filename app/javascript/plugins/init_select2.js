import $ from 'jquery';
 import 'select2';
 import 'select2/dist/css/select2.min.css';

 const initSelect2 = () => {
   console.log('hello')
   $("#search_tag_ids").select2();
   $("#search_tag_ids").select2();
 }


 export { initSelect2 }
