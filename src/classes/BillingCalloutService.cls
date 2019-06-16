public class BillingCalloutService {
    //Implement business and callout logic methods here
    @TestVisible
    private static final String BILLING_SERVICE_CREDENTIALS = 'BillingServiceCredential';
    
    private static final ServiceCredentials__c CREDENTIALS = ServiceCredentials__c.getinstance(BILLING_SERVICE_CREDENTIALS);

    @future(callout=true)
    public static void callBillingService(String projectId){

        Project__c pj = [
            Select Id, ProjectRef__c, Billable_Amount__c From Project__c
            Where Id =: projectId
        ];

        //送信しない
        if (pj == null || pj.ProjectRef__c == null || pj.Billable_Amount__c == null) 
        return;

    // project
    BillingServiceProxy.project soapProject = new BillingServiceProxy.project();
    soapProject.projectid = pj.ProjectRef__c;
    soapProject.billAmount = pj.Billable_Amount__c;
    soapProject.username = CREDENTIALS.Username__c;
    soapProject.password = CREDENTIALS.Password__c;

    //callout
    BillingServiceProxy.InvoicesPortSoap11 port = new BillingServiceProxy.InvoicesPortSoap11();
    String response = port.billProject(soapProject);
    
    //update project on success
    if (response == 'OK') {
        pj.Status__c = 'Billed';
        update pj;
    }

    }

}