public class AccountTriggerHandler {
    /*
    * Question 1
    * Account Trigger
    * When an account is inserted change the account type to 'Prospect' if there is no value in the type field.
    * Trigger should only fire on insert.
    */
    public static void setTypeProspect(List<Account> newAccounts){
        for(Account acc: newAccounts){
            if(String.isBlank(acc.Type)){
                acc.Type = 'Prospect';
            }
        }
    }
    /* Question 2
    * Account Trigger
    * When an account is inserted copy the shipping address to the billing address.
    * BONUS: Check if the shipping fields are empty before copying.
    * Trigger should only fire on insert.
    */
    public static void copyShippingAddressToBillingAddress(List<Account> accList){
        for(Account acc: accList){
            if(acc.shippingCity!=null){
                acc.BillingCity = acc.shippingCity;
            }
            if(acc.shippingCountry!=null){
                acc.BillingCountry = acc.shippingCountry;
            }
            if(acc.shippingState!=null){
                acc.BillingState = acc.shippingState;
            }
            if(acc.shippingStreet!=null){
                acc.BillingStreet = acc.shippingStreet;
            }
            if(acc.shippingPostalCode!=null){
                acc.BillingPostalCode = acc.shippingPostalCode;
            }
        }
    }
     /*
    * Question 3
    * Account Trigger
	* When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
    * Trigger should only fire on insert.
    */
   public static void setRating(List<Account> newAccounts){
        for(Account acc : newAccounts){
            if(acc.phone != null && acc.Website != null && acc.Fax != null){
                acc.Rating = 'Hot';
            }
        }
    }
    /*
    * Question 4
    * Account Trigger
    * When an account is inserted create a contact related to the account with the following default values:
    * LastName = 'DefaultContact'
    * Email = 'default@email.com'
    * Trigger should only fire on insert.
    */
    public static void setDefaultContact(List<Account> accList){
        List<Contact> contactToBeInserted = new List<Contact>();
        for(Account acc : accList){
            Contact con = new Contact(
                LastName = 'DefaultContact',
                Email = 'default@email.com',
                AccountId = acc.Id);
            contactToBeInserted.add(con);
        }

        if(!contactToBeInserted.isEmpty()){
            insert contactToBeInserted;
        }
    }
   
}