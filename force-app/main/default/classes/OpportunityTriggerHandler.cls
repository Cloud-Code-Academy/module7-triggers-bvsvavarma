public with sharing class OpportunityTriggerHandler {
    /*
    * Question 5
    * Opportunity Trigger
    * When an opportunity is updated validate that the amount is greater than 5000.
    * Error Message: 'Opportunity amount must be greater than 5000'
    * Trigger should only fire on update.
    */
    public static void amountValidation(List<Opportunity> newOpty, Map<Id, Opportunity> OldMap){
        for(Opportunity newRecord : newOpty){  
            Opportunity oldOpty = OldMap.get(newRecord.Id);
            if(newRecord.Amount != oldOpty.Amount){
                if (newRecord.Amount != null && newRecord.Amount <= 5000) {
                    newRecord.Amount.addError('Opportunity amount must be greater than 5000');
                }
            }
        }
    }
    /*
     * Question 6
	 * Opportunity Trigger
	 * When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
	 * Error Message: 'Cannot delete closed opportunity for a banking account that is won'
	 * Trigger should only fire on delete.
	 */
    public static void preventDeletionOfCloseWonOpportunity(List<Opportunity> oldOpty){
        //Set to hold Account Ids of Opportunity
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opty : oldOpty){
            accountIds.add(opty.AccountId);
        }

        //Map to Hold Id and Account 
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accountIds]);

        for(Opportunity opp: oldOpty){
            Account relatedAccount = accountMap.get(opp.AccountId);
            if(opp.StageName == 'Closed Won' && relatedAccount != null && relatedAccount.Industry == 'Banking'){
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }
    /*
    * Question 7
    * Opportunity Trigger
    * When an opportunity is updated set the primary contact on the opportunity to the contact on the same account with the title of 'CEO'.
    * Trigger should only fire on update.
    */
        public static void updatePrimaryContact(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap) {
            
            Set<Id> accountIds = new Set<Id>();
            
            // Collect Account IDs from updated Opportunities
            for (Opportunity opp : newOpps) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
    
            // Map to hold CEO contacts by Account ID
            Map<Id, Contact> ceoContacts = new Map<Id, Contact>();
    
            // Query for Contacts with the title 'CEO' related to the Accounts
            if (!accountIds.isEmpty()) {
                List<Contact> ceoList = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO'];
                for (Contact ceo : ceoList) {
                    ceoContacts.put(ceo.AccountId, ceo);
                }
            }
    
            // List to hold Opportunities to update
            List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
    
            // Update Opportunities with the CEO Contact
            for (Opportunity opp : newOpps) {
                Opportunity oldOpp = oldOppMap.get(opp.Id);
                
                // Check if the Opportunity is updated and needs a new primary contact
                if (opp.AccountId != null && opp.AccountId != oldOpp.AccountId || opp.Primary_Contact__c != ceoContacts.get(opp.AccountId)?.Id) {
                    opp.Primary_Contact__c = ceoContacts.get(opp.AccountId)?.Id;
                }
            }
        }
    }
