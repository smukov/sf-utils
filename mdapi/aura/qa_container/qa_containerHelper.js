({
  /**
   * Disable or enable a specific button in Quick Action dialog
   * 
   * @param {string} btnName name of a button to disable/enable
   * @param {bool} isDisabled TRUE - disables the button, FALSE - enables it
   */
  disableQAButton : function(cmp, btnName, isDisabled){
    const buttons = cmp.get('v.buttons');

    for(let i = 0; i < buttons.length; i++){
      if(buttons[i].name === btnName){
        buttons[i].isDisabled = isDisabled;
      }
    }

    cmp.set('v.buttons', buttons);
  },

  /**
   * Disable or enable all buttons in Quick Action dialog
   * 
   * @param {bool} isDisabled TRUE - disables the button, FALSE - enables it
   */
  disableAllQAButtons : function(cmp, isDisabled){
    const buttons = cmp.get('v.buttons');

    for(let i = 0; i < buttons.length; i++){
      buttons[i].isDisabled = isDisabled;
    }

    cmp.set('v.buttons', buttons);
  }
})