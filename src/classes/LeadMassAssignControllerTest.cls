@isTest
private class LeadMassAssignControllerTest {
    
    @isTest
    private static void getAvailableUsers() {

        // Define params for the test
        User stephen = [SELECT Id FROM User WHERE LastName = 'Strange (TEST)'];

        // Do the test
        Test.startTest();

        List<User> users = null;
        System.runAs(stephen) {
            users = LeadMassAssignController.getAvailableUsers();
        }

        // Validate results
        Test.stopTest();

        System.assertNotEquals(true, users.isEmpty(),
                'At least one user should be available!');
    }

    @isTest
    public static void assignOwner() {

        // Define params for the test
        User stephen = [SELECT Id FROM User WHERE LastName = 'Strange (TEST)'];
        User christine = [SELECT Id FROM User WHERE LastName = 'Palmer (TEST)'];

        Lead bruce = [
            SELECT Id FROM Lead
            WHERE LastName = 'Wayne (TEST)' AND OwnerId = :stephen.Id
        ];
        Lead clark = [
            SELECT Id FROM Lead
            WHERE LastName = 'Kent (TEST)' AND OwnerId = :stephen.Id
        ];

        // Do the test
        Test.startTest();

        List<Lead> leads = null;
        System.runAs(stephen) {
            leads = LeadMassAssignController.assignOwner(
                    christine.Id, new List<Id> { bruce.Id, clark.Id });
        }

        // Validate results
        Test.stopTest();

        bruce = [SELECT Id, OwnerId FROM Lead WHERE Id = :bruce.Id];
        clark = [SELECT Id, OwnerId FROM Lead WHERE Id = :clark.Id];

        System.assertEquals(christine.Id, bruce.OwnerId,
                'Christine should now own the Bruce Wayne lead');
        System.assertEquals(christine.Id, clark.OwnerId,
                'Christine should now own the Clark Kent lead');
    }

    @testSetup
    private static void setup() {

        // Create internal users
        Profile bdrUserProfile =
                [SELECT Id FROM Profile WHERE Name = 'Standard User'];

        User stephen = new User(
                FirstName = 'Stephen',
                LastName = 'Strange (TEST)',
                ProfileId = bdrUserProfile.Id,
                Username = 'stephen.strange@marvel.test',
                Email = 'stephen.strange@marvel.test',
                Alias = 'sstra',
                CommunityNickname = 'stephen.strange.test',
                TimeZoneSidKey = UserInfo.getTimeZone().toString(),
                LocaleSidKey = UserInfo.getLocale(),
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = UserInfo.getLanguage());

        User christine = new User(
                FirstName = 'Christine',
                LastName = 'Palmer (TEST)',
                ProfileId = bdrUserProfile.Id,
                Username = 'christine.palmer@marvel.test',
                Email = 'christine.palmer@marvel.test',
                Alias = 'cpalm',
                CommunityNickname = 'christine.palmer.test',
                TimeZoneSidKey = UserInfo.getTimeZone().toString(),
                LocaleSidKey = UserInfo.getLocale(),
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = UserInfo.getLanguage());

        insert new List<User> { stephen, christine };

        // Create some leads
        Lead bruce = new Lead(
                FirstName = 'Bruce',
                LastName = 'Wayne (TEST)',
                Company = 'DC Extended Universe');

        Lead clark = new Lead(
                FirstName = 'Clark',
                LastName = 'Kent (TEST)',
                Company = 'DC Extended Universe');

        System.runAs(stephen) {
            insert new List<Lead> { bruce, clark };
        }
    }
}