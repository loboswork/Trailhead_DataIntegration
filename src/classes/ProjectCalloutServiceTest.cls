@isTest
private class ProjectCalloutServiceTest {
  //Implement mock callout tests here
  @TestSetup
  private static void setup(){
    ServiceTokens__c st = new ServiceTokens__c(
      name = ProjectCalloutService.PROJECT_SERVICE_TOKEN_NAME,
      Token__c = 'test_service_token'
    );
    insert st;
  }

  @isTest
  private static void testFailure() {
    Opportunity opp = OpportunityFactory.createOpportunitiy(OpportunitySelector.STAGE_CLOSED_WON);
    insert opp;

    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
    ProjectCalloutService.postOpportunityToPMS(new List<Id>{opp.Id});
    Test.stopTest();

    List<Opportunity> Opportunities = OpportunitySelector.getOpportunities(new Set<Id>{opp.Id});
    System.assertEquals(OpportunitySelector.STAGE_RESUBMIT_PROJECT, Opportunities.get(0).StageName);


  }

   @isTest
  private static void testSuccess() {
    Opportunity opp = OpportunityFactory.createOpportunitiy(OpportunitySelector.STAGE_CLOSED_WON);
    insert opp;

    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
    ProjectCalloutService.postOpportunityToPMS(new List<Id>{opp.Id});
    Test.stopTest();

    List<Opportunity> Opportunities = OpportunitySelector.getOpportunities(new Set<Id>{opp.Id});
    System.assertEquals(OpportunitySelector.STAGE_Submitted_PROJECT, Opportunities.get(0).StageName);


  }




}