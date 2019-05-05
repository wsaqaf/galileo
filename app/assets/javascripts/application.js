// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require areyousure/jquery.are-you-sure.js

jQuery(function() {
  $('#user_affiliation').autocomplete({source: $('#user_affiliation').data('autocomplete-source')});
});

function NewMedium(c,s,p,w) {
  var element;
  if (c==1) { element = document.getElementById('claim_'+s+'_name'); }
  else { element = document.getElementById(s+'_name'); }
  var q = element.value;
  q=$.trim(q);
  const note = document.getElementById(s+'_note');
  if (q.length==0) { note.innerHTML=''; return ; }
  $.ajax({
    url: '/'+p+'/?term='+q,
    cache: false
  })
    .done(function( html ) {
      var found=false;
      var entry="";
      for(var i = 0; i < html.length; i++)
        {
          if (html[i].toLowerCase()==q.toLowerCase())
            {
              entry=html[i]
              found=true;
              break;
            }
        }
      if (found)
        {
          if (c==1) { element.value=entry; note.innerHTML=''; }
          else
          {
            note.innerHTML='<b><font color=red>'+q+'</font></b> cannot be added because it is already in the database. You can find it by clicking on the <a href="/'+p+'" target=_blank>'+w+' page</a><br>';
            document.getElementById("submit").disabled = true;
          }
        }
      else
        {
          if (c==1) { note.innerHTML='<b><font color=red>'+q+'</font></b> is new and will be added automatically to the '+w+' database. You can find it by clicking on the <a href="/'+p+'" target=_blank>'+w+' page</a> after submitting this form.<br><br>'; }
          else
          {
            note.innerHTML='';
            document.getElementById("submit").disabled = false;
          }
        }
    });
}
function do_submit(s)
{
  if ($("#final_url_preview").html().length>10)
  {
    $("#"+s+"_url_preview").val("<br><div id=\"final_url_preview\" class=\"fragment\">"+addslashes($("#final_url_preview").html())+"</div>");
    $(+s+"_url_preview").val($("#final_url_preview").html());
    return false;
  }
}
function update_display(s)
 {
  if ($('#skip_preview').is(':checked')) { $("#preview_block").hide(); $("#url_preview_block").html(""); $('#'+s+'_url_preview').val(' '); }
  else { $("#preview_block").show(); URLPreview(s); }
}
function addslashes( str ) { return (str + '').replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0'); }
function URLPreview(s)
 {
  $("#url_preview_block").html("<br><center><img src='/loading.gif' width=50></center><br>");
  const element = document.getElementById(s+'_url');
  var q = element.value;
  q=$.trim(q);
  if (q.length==0) { $("#url_preview_block").html(""); $('#'+s+'_url_preview').val(' '); return ; }
  $.ajax({
    url: '/claims/',
    type: 'get',
    data: { url: q },
    dataType: "text",
    success:function(result)
      {
        if (result.length>0) { $('#'+s+'_url_preview').val(addslashes(result)); $("#url_preview_block").html("<div id='preview_block'>"+result+"</div><input type='checkbox' id='skip_preview' value=1 onchange='update_display(\""+s+"\")'><small> Skip preview</small><br>"); }
        else { $('#'+s+'_url_preview').val(' '); $("#url_preview_block").html("<center><small>[URL does not have a preview]</small></center>"); }
      },
    error:function()
      {
        $('#'+s+'_url_preview').val(' '); $("#url_preview_block").html("<center><small>[URL does not have a preview]</small></center>");
      }
    });
 }

 function ResponsiveMenu() {
   var x = document.getElementById("myTopnav");
   if (x.className === "topnav") {
     x.className += " responsive";
   } else {
     x.className = "topnav";
   }
 }
