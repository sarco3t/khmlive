$(document).ready(function () {
    // $('select.selectCategory').selectize({
    //     create: false,
    //     sortField: 'text',
    //     searchField: 'disabled'
    // });

   $('select.selectCategory').select2({
       allowClear: false,
       minimumResultsForSearch: -1
   });

   $('select.selectCategory_modal').select2({
       allowClear: false,
       minimumResultsForSearch: -1,
       dropdownParent: $('#addNews')
   });

    $('select.selectCategory_modal2').select2({
        allowClear: false,
        minimumResultsForSearch: -1,
        dropdownParent: $('#addPoster')
    });

   $('input.datepicker_input').datepicker({
       dateFormat: "dd.mm.yy"
   });

   $('a.button_calendar').on('click', function (e) {
      e.preventDefault();

      $('.datepicker_input.hidden_calendar').datepicker("show");
   });

   $('.catalog_category .category_item a').on('click', function (e) {
       e.preventDefault();

       var current = $(this).parent();

       if($(current).hasClass('current-active')) {
           $(current).removeClass('current-active');
       } else {
           $('.catalog_category .category_item').removeClass('current-active');
           $(current).addClass('current-active');
       }
   });
    
   $('.im_dialog_tools .search_dialog a').on('click', function (e) {
       e.preventDefault();

       $('.im_dialog_tools').hide();

       $('.im_dialog_search').show();
   });

   $('.important_dialog a').on('click', function (e) {
       e.preventDefault();

       $(this).toggleClass('active');
   });

   $('.wrap_adcontent .item_content.inner_content a').on('click', function (e) {
      e.preventDefault();

      var current = $(this).parent().parent();

      if($(current).hasClass('active')) {
          $(current).removeClass('active');
      } else {
          $('.wrap_adcontent .item_content.inner_content').removeClass('active');
          $(current).addClass('active');
      }
   });

   $('.im_dialog_search button.cancel_search').on('click', function () {
       $('.im_dialog_search').hide();

       $('.im_dialog_tools').show();
   });

   $('.nav-mobile a.search-button').on('click', function (e) {
      e.preventDefault();

      $('header .search-mobile').toggleClass('show');
   });

   $('.nav-mobile a.signin-button').on('click', function (e) {
      e.preventDefault();

      $(this).toggleClass('active');
      $(this).parent().find('.nav-mobile-sub').toggleClass('active');
   });
    
   $('a.like_btn.like, a.like_btn.share ').on('click', function (e) {
       e.preventDefault();

       $(this).parent().toggleClass('active');
       var like_button = $(this).find('.like_button_count');

       var count = $(like_button).text();

       if(!$(this).hasClass('active')) {
           count --;
       } else {
           count ++;
       }

       if(count == 0) {
           var count = '';
       }
       $(like_button).text(count);
   });

   $('.reply_box_attach_image a').on('click', function (e) {
       e.preventDefault();

       $(this).parent().find('input').click();
   });
    
   $('.action-header a').on('click', function (e) {
       e.preventDefault();

       var name = $(this).attr('href');

       console.log(name);

       $(name + 'Modal').modal('toggle');
   });

   $('.mobile-content a.show_popular').on('click', function (e) {
       e.preventDefault();

       $(this).toggleClass('active');

       $(this).parent().parent().find('.hide_default').toggleClass('show');
   });
    
   // remove
   $('#signinModal .link_action a').on('click', function (e) {
      e.preventDefault();

      var name = $(this).attr('href');

      console.log(name);

      $('#signinModal').modal('hide');

      $(name + 'Modal').modal('toggle');
   });

   $('#forgotModal button.btn').on('click', function () {
       $('#forgotModal').modal('hide');

       $('#forgotCodeModal').modal('toggle');
   });
});

function resizeArea(text_id, minHeight, maxHeight)
{
    console.log(text_id);

    var area = $(text_id);
    var area_hidden = $(text_id);
    var text = '';
    area.value.replace(/[<>]/g, '_').split("\n").each( function(s) {
        text = text + '<div>' + s.replace(/\s\s/g, ' &nbsp;') + '&nbsp;</div>'+"\n";
    } );
    area_hidden.innerHTML = text;
    var height = area_hidden.offsetHeight + 15;
    height = Math.max(minHeight, height);
    height = Math.min(maxHeight, height);
    area.style.height = height + 'px';
}