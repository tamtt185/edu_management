$(document).on('turbolinks:load', function() {
  TablesDatatables.init();
  $(".toggle-sidebar").click(function(){
    App.sidebar('toggle-sidebar');
  });

  $(".month-budgets").change(function(){
    $(".month-payment").val($(".month-budgets").val());
  });

  $(".chosen-budget").submit(function(){
    var date_regex = /^(0[1-9]|1[0-2])\/(19|20)\d{2}$/ ;
    if(!(date_regex.test($(".month-payment").val())))
    {
      alert(I18n.t('validation_moth_budget'));
      $("#month_of_payment_").datepicker("show");
      return false;
    }
    $(".month-payment").val($(".month-budgets").val());
  });

  $(".month-budgets").datepicker( {
    format: "mm/yyyy",
    startView: "year",
    minView: "year"
  });

});

function removeBudget(self){
  $(".budgeted-tag").removeTag(self.attr('id'));
  self.remove();
}
