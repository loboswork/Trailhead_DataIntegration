public class OpportunitySelector {

    public static final String STAGE_CLOSED_WON = 'Closed Won';
    public static final String STAGE_RESUBMIT_PROJECT = 'Resubmit Projec';
    public static final String STAGE_Submitted_PROJECT = 'Submitted Project';

    public static List<Opportunity> getOpportunities(Set<Id> ids) {
        return [
            Select 
                StageName 
            From
                Opportunity
            Where
                Id IN : ids
        ];
        
    }
}