$(document).ready(function() {
    
  $(".open").live("click", function (){
    $(this).removeClass("open");
    $(this).addClass("selected");
    $(this).text("Selected");
    $("#submit-button").show();
    showReservation($(this).attr("id"));
    insertFields($(this).attr("id"));
  });
  
  $(".reserved").live("click", function (){
    thisDateTime = $(this).attr("id").split("-")
    thisHour = thisDateTime[1]
    thisYear = thisDateTime[2].substr(0,4)
    thisMonth = thisDateTime[2].substr(4,2)
    thisDay = thisDateTime[2].substr(6,2)
    selectedTime = new Date(thisYear, thisMonth - 1, thisDay, thisHour, 0, 0, 0)
    rightNow = new Date();
    dateDifference = (selectedTime - rightNow) / (1000*60*60);
    if (dateDifference > 24 || $(this).hasClass("admin")){
      $(this).removeClass("owned");
      $(this).removeClass("reserved");
      $(this).addClass("cancelled");
      $(this).text("Cancelled");

      $("#submit-button").fadeIn();
      insertFields($(this).attr("id"), true);
      showCancellation($(this).attr("id"));
      $("#success").hide();        
    } else {
      alert("Sorry - you can't cancel a reservation with less than 24 hours notice.");    
    }
   });
   
   $(".unavailable.admin").live("click", function(){
     $(this).removeClass("unavail.");
     $(this).addClass("cancelled");
     $(this).text("Cancelled");

     $("#submit-button").fadeIn();
     insertFields($(this).attr("id"), true);
     showCancellation($(this).attr("id"));    
   });
   
   
   $(".selected").live("click", function (){
     $(this).removeClass("selected");
     $(this).addClass("open");
     $(this).text("Open");
     $("input." + $(this).attr("id")).remove();
     hideReservation($(this).attr("id"));
     if ($("#reservations-form input").length == 2){
       $("#submit-button").fadeOut();
     }
   }); 
   
  $(".cancelled").live("click", function (){
    $(this).removeClass("cancelled");
    $(this).addClass("reserved");
    $(this).text("Reserved");    
    $("input." + $(this).attr("id")).remove();
    hideCancellation($(this).attr("id"));
    if ($("#reservations-form input").length == 2){
      $("#submit-button").fadeOut();
    }
  });

  
});
    
function insertFields(strFields, isCancelled) {
  if (isCancelled == null){
    isCancelled = false;
  }
  fields = strFields.split("-");
  
  $("#submit-button").before("<input class=\"pending-reservation " + strFields + "\" type=\"hidden\" name=\"reservation[][press_id]\" value=\"" + fields[0] + "\" />");
  $("#submit-button").before("<input class=\"pending-reservation " + strFields + "\" type=\"hidden\" name=\"reservation[][hour]\" value=\"" + fields[1] + "\" />");
  $("#submit-button").before("<input class=\"pending-reservation " + strFields + "\" type=\"hidden\" name=\"reservation[][date]\" value=\"" + fields[2] + "\" />");
  $("#submit-button").before("<input class=\"pending-reservation " + strFields + "\" type=\"hidden\" name=\"reservation[][user_id]\" value=\"" + user_id + "\" />");
  $("#submit-button").before("<input class=\"pending-reservation " + strFields + "\" type=\"hidden\" name=\"reservation[][cancelled]\" value=\"" + isCancelled + "\" />");
}

function showReservation(strId) {
  parts = strId.split("-");
  $(".unbooked-press #press-name-" + parts[0]).show();
  $(".unbooked-press #press-" + parts[0] + "-hour-" + parts[1]).show();
  $("#your-unsaved-selections").show();
}
function hideReservation(strId) {
  parts = strId.split("-");
  $(".unbooked-press #press-" + parts[0] + "-hour-" + parts[1]).hide();
  if ($(".unbooked-press .child-of-press-" + parts[0] + ":visible").size() == 0) {
    $(".unbooked-press #press-name-" + parts[0]).hide();
  }
  if ($(".unbooked-press .press-name:visible").size() == 0) {
    $('#your-unsaved-selections').hide();
  }
}
function showCancellation(strId) {
  parts = strId.split("-");
  $(".cancelled-press #press-name-" + parts[0]).show();
  $(".cancelled-press #press-" + parts[0] + "-hour-" + parts[1]).show();
  $("#your-unsaved-cancellations").show();
}
function hideCancellation(strId) {
  parts = strId.split("-");
  $(".cancelled-press #press-" + parts[0] + "-hour-" + parts[1]).hide();
  if ($(".cancelled-press .child-of-press-" + parts[0] + ":visible").size() == 0) {
    $(".cancelled-press #press-name-" + parts[0]).hide();
  }
  if ($(".cancelled-press .press-name:visible").size() == 0) {
    $('#your-unsaved-cancellations').hide();
  }
}


function setSelections(){

  $(".pending-reservation[name='reservation[][date]']").each(function (index, obj) {
    if ($("#" + $(obj).attr("class").split(' ')[1]).hasClass("open")){
      $("#" + $(obj).attr("class").split(' ')[1]).removeClass("open");
      $("#" + $(obj).attr("class").split(' ')[1]).addClass("selected");
    } else if($("#" + $(obj).attr("class").split(' ')[1]).hasClass("reserved")){
      $("#" + $(obj).attr("class").split(' ')[1]).removeClass("reserved");
      $("#" + $(obj).attr("class").split(' ')[1]).addClass("open");
      $("#" + $(obj).attr("class").split(' ')[1]).find(".message").text("");
    }
  });
}
function setToolTips(){
    $("strong.unavailable.admin").qtip({
       
       show: 'mouseover',
       hide: 'mouseout',
       position: {
         corner: {
           target: 'topLeft',
           tooltip: 'bottomLeft'
         }
      }

    }); 
}