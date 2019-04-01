({
  handleInit : function(cmp, event, helper) {
    helper.disableAllQAButtons(cmp, false);
  },

  handleQABtnClicked : function(cmp, event, helper) {
    event.stopPropagation();
    const btnName = event.getParam('data').name;
    alert(btnName + ' clicked');

    // disable the button that was clicked
    helper.disableQAButton(cmp, btnName, true);
  }
})
