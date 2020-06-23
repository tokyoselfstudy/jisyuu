$(function() {
  $('.learn-record-menu').on('click', function(e){
    e.preventDefault();
    console.log('hoge')
    var learn_record_id;
    learn_record_id = $(this).data('learn_record_id')
    window.location.href = `/learn_records/${learn_record_id}/menu`
  })
})