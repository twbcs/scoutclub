
$(function(){
    $('#datetimepicker1').datetimepicker();
		$('#datetimepicker2').datetimepicker();
		$('#datetimepicker3').datetimepicker();
		$("#datetimepicker1").on("dp.change",function (e) {
      $('#datetimepicker2').data("DateTimePicker").setMinDate(e.date);
            });
    $("#datetimepicker2").on("dp.change",function (e) {
      $('#datetimepicker1').data("DateTimePicker").setMaxDate(e.date);
            });
});
