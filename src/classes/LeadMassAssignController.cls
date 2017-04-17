public with sharing class LeadMassAssignController {

    /**
     * Get a list of available users to present for the selection of a new
     * lead owner.
     *
     * @return a list of User objects representing available, selectable users
     */
    @AuraEnabled
    public static List<User> getAvailableUsers() {
        return [
            SELECT Id, Name
            FROM User
            WHERE IsActive = TRUE 
            ORDER BY FirstName, LastName
        ];
    }

    /**
     * Assign a new owner to a given list of leads.
     *
     * @param  ownerId The User ID of the new lead owner to be assigned
     * @param  leadIds The list of Lead IDs for leads to reassign
     * @return the list of updated leads
     */
    @AuraEnabled
    public static List<Lead> assignOwner(Id ownerId, List<Id> leadIds) {
        List<Lead> leads = new List<Lead>();

        for (Id theLeadId : leadIds) {
            leads.add(new Lead(Id = theLeadId, OwnerId = ownerId));
        }

        update leads;
        return leads;
    }
}