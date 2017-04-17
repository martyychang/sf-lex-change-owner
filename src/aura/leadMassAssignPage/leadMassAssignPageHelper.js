({
  assignOwner : function(component, ownerId, leadIds,
                         successCallback, errorCallback) {
    
    var action = component.get("c.assignOwner");

    action.setParams({
      ownerId: ownerId,
      leadIds: leadIds
    });

    action.setCallback(this, function(response) {
      console.log("response: %o", response);

      if (response.getState() === "SUCCESS") {
        if (successCallback) {
          successCallback();
        }
        else {
          alert("success");
        }
      }
      else if (response.getState() === "ERROR") {
        if (errorCallback) {
          errorCallback();
        }
        else {
          alert("error");
        }
      }
    });

    $A.enqueueAction(action);
  },
  refreshOwnerOptions : function(component, helper) {
    var action = component.get("c.getAvailableUsers");

    action.setCallback(this, function(response) {
      console.log("response: %o", response);

      if (response.getState() === "SUCCESS") {
        component.set("v.availableUsers", response.getReturnValue());
      }
      else if (response.getState() === "ERROR") {
        alert("error");
      }
    });

    $A.enqueueAction(action);
  }
})