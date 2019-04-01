({
  showToast : function(type, title, message) {
    const toastEvent = $A.get("e.force:showToast");
    if(toastEvent){
      toastEvent.setParams({
        "type" : type,
        "title": title,
        "message": message
      });
      toastEvent.fire();
    }else{
      console.log(type, title, message);
    }
  },

  refreshPage: function () {
		$A.get('e.force:refreshView').fire();
	},
})