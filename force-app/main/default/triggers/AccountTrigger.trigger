trigger AccountTrigger on Account (before insert, after insert) {
    /*CONTEXT VARIABLE (values which developer needs to write logic)
    CONTEXT Variable 1: Trigger.new -> List of records that are got inserted
    CONTEXT Variable 2: Trigger.isBefore -> Return true if trigger is running on before event
    CONTEXT Variable 3: Trigger.isInsert -> Return true if trigger is called when user has done insert operation
    CONTEXT Variable 4: Trigger.isAfter -> Return true if trigger is running on after the record is inserted/updated
    CONTEXT Variable 5: Trigger.newMap -> Return the list of records that are inserted/updated with latest values in map format   
    CONTEXT Variable 6: Trigger.oldMap -> Return the list of records that are inserted/updated with old/prior values in map format
    CONTEXT Variable 7: Trigger.old -> Return the list of records that are inserted/updated with old/prior values
    CONTEXT Variable 8: Trigger.isUpdate -> Returns true if trigger is called when record is updated.
    CONTEXT Variable 9: Trigger.isDelete -> Return true if trigger is called when user has done delete operation
    CONTEXT Variable 10: Trigger.isUnDelete -> Return true if trigger is called when user has done undelete operation
    */

    //THUMB RULE : DECIDE BEFORE OR AFTER
    //If we need to update/prepopulate any field(s) on the same record or to fire an error validating the record the go woth BEFORE EVENT
    //In any other condition, JUMP to AFTER EVENT 
    /*
    * Question 1
    * Account Trigger
    * When an account is inserted change the account type to 'Prospect' if there is no value in the type field.
    * Trigger should only fire on insert.
    */

    /*
    * Question 2
    * Account Trigger
    * When an account is inserted copy the shipping address to the billing address.
    * BONUS: Check if the shipping fields are empty before copying.
    * Trigger should only fire on insert.
    */
     /*
    * Question 3
    * Account Trigger
	* When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
    * Trigger should only fire on insert.
    */
    if(Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.setTypeProspect(Trigger.new);
        AccountTriggerHandler.copyShippingAddressToBillingAddress(Trigger.new);
        AccountTriggerHandler.setRating(Trigger.new);
    }
   

    /*
    * Question 4
    * Account Trigger
    * When an account is inserted create a contact related to the account with the following default values:
    * LastName = 'DefaultContact'
    * Email = 'default@email.com'
    * Trigger should only fire on insert.
    */

    if(Trigger.isAfter && Trigger.isInsert){
        AccountTriggerHandler.setDefaultContact(Trigger.new);
    }
}
