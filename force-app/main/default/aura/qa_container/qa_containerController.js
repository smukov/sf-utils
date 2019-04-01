({
  handleQAButtonClicked : function(cmp, event, helper){
    const name = event.getSource().get('v.name');
    const e = cmp.getEvent('qaBtnClicked');
    e.setParams({
      'data': {'name': name}
    });
    e.fire();
  }
})