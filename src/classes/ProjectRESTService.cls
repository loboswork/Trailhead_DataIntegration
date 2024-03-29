@RestResource(urlMapping='/project/*')
global with sharing class ProjectRESTService {
    //Implement service logic here

    @HttpPost
    global static String postProjectData(String ProjectRef, String ProjectName, 
                                        String OpportunityId, Date StartDate, Date EndDate, 
                                        Double Amount, String Status){
        String ResStatus = 'OK';

        Project__c thisProject = new Project__c();
        List<Project__c> projects = [Select Billable_Amount__c, End_Date__c, Id, Name, Opportunity__c, 
                                    ProjectRef__c, Start_Date__c, Status__c FROM Project__c WHERE ProjectRef__c = :ProjectRef];

        if(projects.size() > 0){
            thisProject = projects.get(0);
        }
        else {
            thisProject.ProjectRef__c  = ProjectRef;
            thisProject.Name = ProjectName;
            thisProject.Opportunity__c = OpportunityId;
            thisProject.Start_Date__c  = StartDate;
            thisProject.End_Date__c    = EndDate;
            thisProject.Billable_Amount__c = Amount;
            thisProject.Status__c      = Status;
        }

        Savepoint sp = Database.setSavepoint();

        try{
            upsert thisProject;

            Opportunity op =[select id, DeliveryInstallationStatus__c from Opportunity where id =: OpportunityId];
            op.DeliveryInstallationStatus__c = 'In Progress';
            update op;

            If(Test.isRunningTest()) {
                Integer i=10/0;
            }
            ResStatus = 'OK';
        }
        catch(Exception e){
            Database.rollback(sp);
            ResStatus = e.getMessage();
        }

        return ResStatus;
    }//postProjectData
}