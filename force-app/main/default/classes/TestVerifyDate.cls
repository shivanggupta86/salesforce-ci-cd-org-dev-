@isTest
public class TestVerifyDate {
    
    @isTest
    static void TestCheckDates1(){
        Date d = VerifyDate.CheckDates(date.parse('01/01/2022'), date.parse('01/05/2022'));
        system.assertEquals(date.parse('01/05/2022'), D);   
    }
    
    @isTest
    static void TestCheckDates2(){
        Date d = VerifyDate.CheckDates(date.parse('01/01/2022'), date.parse('05/05/2022'));
        system.assertEquals(date.parse('01/31/2022'), D);   
    }
    
    @isTest
    static void TestDateWithin30Days_case1(){
        Boolean flag = verifyDate.DateWithin30Days(date.parse('01/01/2022'), date.parse('12/30/2021'));
        system.assertEquals(false, flag);
    }
    @isTest
    static void TestDateWithin30Days_case2(){
        Boolean flag = verifyDate.DateWithin30Days(date.parse('01/01/2022'), date.parse('02/02/2022'));
        system.assertEquals(false, flag);
    }
    @isTest
    static void TestDateWithin30Days_case3(){
        Boolean flag = verifyDate.DateWithin30Days(date.parse('01/01/2022'), date.parse('01/15/2022'));
        system.assertEquals(true, flag);
    }
    @isTest
    static void TestSetEndOfMonthDate(){
        date returnDate = verifyDate.SetEndOfMonthDate(date.parse('01/01/2022'));
    }
}