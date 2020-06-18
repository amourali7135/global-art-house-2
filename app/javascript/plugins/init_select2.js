import $ from 'jquery';
 import 'select2';
//  import 'select2/dist/css/select2.min.css';

 const initSelect2 = () => {
   console.log('hello')
   $("#search_tag_ids").select2();
   $("#browse_genre_tags").select2();
   $("#artist_kinds_search").select2();
   $("#artists_country_search").select2();
   $("#artist_search_country").select2();
   $("#artist_edit_tags").select2();
   $("#artist_new_tags").select2();
   $("#art_edit_kinds").select2();
   $("#art_edit_types").select2();
   $("#art_new_types").select2();
   $("#art_new_kinds").select2();
   $("#browse_country").select2();
   $("#search_country").select2();
   $("#country_select").select2();
   $("#country_select_again").select2();
   $("#home_page_country_1").select2();
   $("#home_page_country_2").select2();
   $("#artist_styles_search").select2();
   $("#artist_new_styles").select2();
   $("#browse_art_media").select2();
    // $("#search_tag_ids").select2({
    //   multiple: true
    // });

 }


 export { initSelect2 }
