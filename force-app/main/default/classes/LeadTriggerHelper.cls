public class LeadTriggerHelper extends TriggerHandler {
    // Get the current user's profile Id
        Id profileId = UserInfo.getProfileId();
     // get profile-level setting for the current profile
        triggerTurnedOff__c profileSetting = triggerTurnedOff__c.getInstance(profileId);
    // get an instance of org-level setting 
    triggerTurnedOff__c orgSetting = triggerTurnedOff__c.getOrgDefaults();
    // Override the afterInsert method from the TriggerHandler base class
    
    public override void afterInsert() {
        // If profile-specific setting is null, fall back to org-level default
        if(profileSetting==null || profileSetting.Trigger_Off__c==false){
            //now check if trigger is disabled at org level
            if (orgSetting == null || orgSetting.Trigger_Off__c == false){
            // Cast Trigger.new to List<Lead>
        List<Lead> newLeadRecords = (List<Lead>) Trigger.new;

        // List to hold new Task records
        List<Task> taskList = new List<Task>();

        // Loop through new Lead records
        for(Lead newLeads: newLeadRecords) {
            // Create new Task for each Lead
            Task t = new Task(
                Subject = 'Followup on new lead ' + newLeads.Company,
                Priority = 'Normal',
                OwnerId = newLeads.OwnerId,
                Status = 'Not Started',
                WhoId = newLeads.Id
            );
            // Add task to the taskList
            taskList.add(t);
        }

        // Insert taskList if it's not empty
        if (!taskList.isEmpty()) {
            insert taskList;
        }
    }
                
            } 
        }
        
}