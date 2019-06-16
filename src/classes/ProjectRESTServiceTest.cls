@isTest
private class ProjectRESTServiceTest {
  //Implement Apex REST service tests here

  @isTest
  static void testCreateProject(){
        //ProjectRESTService
        Date sd = date.today();
        Date ed = sd.addDays(7);
        Opportunity opty = new Opportunity();

        opty.Name = 'Test';
        opty.CloseDate = system.today() + 30;
        opty.Type = 'New Project';
        opty.StageName = 'Sumitted Project';
        insert opty;

        String resStatus = ProjectRESTService.postProjectData('TestProjectRef', 'TestProjectName', Id.valueOf(opty.Id), 
                                                              sd, ed, 100, 'Running');
        // Verify results
        System.assert(resStatus !=null);
        Project__c thisProject = [select id, name from Project__c where name = 'TestProjectName'][0];
        System.assert(thisProject !=null);
        System.assertEquals(thisProject.name, 'TestProjectName');

         resStatus = ProjectRESTService.postProjectData('TestProjectRef', 'TesProjectName', '123', sd, ed, 100, 'Running');
        // Verify results
        System.assert(resStatus != null);
        thisProject = [SELECT Id, name FROM Project__c WHERE name='TesProjectName'][0];
        System.assert(thisProject != null);
        System.assertEquals(thisProject.name, 'TesProjectName');
  }
}