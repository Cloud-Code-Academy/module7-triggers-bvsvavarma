trigger OpportunityTrigger on Opportunity (before update,before delete) {
    /*
    * Question 5
    * Opportunity Trigger
    * When an opportunity is updated validate that the amount is greater than 5000.
    * Error Message: 'Opportunity amount must be greater than 5000'
    * Trigger should only fire on update.
    */
    if(Trigger.isBefore && Trigger.isUpdate){
        OpportunityTriggerHandler.amountValidation(Trigger.new, Trigger.oldMap);
    }
    /*
     * Question 6
	 * Opportunity Trigger
	 * When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
	 * Error Message: 'Cannot delete closed opportunity for a banking account that is won'
	 * Trigger should only fire on delete.
	 */
    if(Trigger.isBefore && Trigger.isDelete){
        OpportunityTriggerHandler.preventDeletionOfCloseWonOpportunity(Trigger.old);
    }

     /*
    * Question 7
    * Opportunity Trigger
    * When an opportunity is updated set the primary contact on the opportunity to the contact on the same account with the title of 'CEO'.
    * Trigger should only fire on update.
    */
    if(Trigger.isBefore && Trigger.isUpdate){
        OpportunityTriggerHandler.updatePrimaryContact(Trigger.new, Trigger.oldMap);
    }
}