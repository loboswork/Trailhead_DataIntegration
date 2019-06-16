trigger ProjectTrigger on Project__c (after update) {
    private static final String STATUS_BILLABLE = 'Billable';

    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            
        }
    }

    // when status is changed to 'Billable', then callbillingservice
    private static void filterStatueChanged(Map<Id, Project__c> oldMap, List<Project__c> newList){
        for (Project__c newProject : newList) {
            if (newProject.Status__c == STATUS_BILLABLE && oldMap.get(newProject.Id).Status__c != STATUS_BILLABLE)
            BillingCalloutService.callBillingService(newProject.Id);
        }
    }

}