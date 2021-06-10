// For use with {shinyrandomizer}
// When document is connected, if the message "updateRandomLink" is sent,
// let's do that.


$(document).ready(function() {

  $('#get-started').on("click", function() {
    console.log("Get started clicked");
    Shiny.setInputValue('getStartedClicked', true);
  });

  $('#consent-tab').on("click", function() {
    console.log("consentTabClicked");
    Shiny.setInputValue('consentTabClicked', true);
  });

});


Shiny.addCustomMessageHandler("updateRandomLink", function(link) {
    console.log(link);
    $('#yes-consent').attr('onclick', 'window.location.replace("' + link + '")');
});


