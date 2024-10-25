trigger LeadTrigger on Lead (after insert) {
    // Call the framework's run method to delegate logic to LeadTriggerHelper
    new LeadTriggerHelper().run();
}
