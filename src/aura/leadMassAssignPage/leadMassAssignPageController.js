({
  handleAssignButtonPress : function(component, event, helper) {
    var ownerId = component.get("v.ownerId");
    console.log("ownerId: %o", ownerId);

    var leads = component.get("v.leads");
    console.log("leads: %o", leads);

    var leadIds = [];
    leads.forEach(function(lead) {
      leadIds.push(lead.Id);
    });

    helper.assignOwner(component, ownerId, leadIds, function() {
      history.back();
    });
  },
  handleInit : function(component, event, helper) {
    helper.refreshOwnerOptions(component, helper);
  }
})