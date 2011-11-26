//
//  CustomerDataHandler.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/21/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "CustomerDataHandler.h"
#import "FMDatabase.h"
#import "Customer.h"
#import "CustomerList.h"
#import "CustomerChild.h"
#import "MJUtility.h"
#import "Hobby.h"
#import "CustomerMember.h"
#import "CustomerWorkPlace.h"
#import "CustomerPatient.h"
#import "CustomerStatus.h"
#import "CustomerProduct.h"
#import "CallHistory.h"
#import "FMDatabaseAdditions.h"
#import "SalesHistory.h"

// prod_brand_code in mst_product_brand is not clean, cuscode in dst_orderdaily is not claen
@implementation CustomerDataHandler





//Get All customer Type send back Array of TypeName 
- (NSMutableArray*)getAllCustomerType
{   
    NSMutableArray *typeList = [[NSMutableArray alloc]init];
    [typeList addObject: [NSString stringWithFormat: @"Today"]];
    [typeList addObject: [NSString stringWithFormat: @"All Profile"]];
    [typeList addObject: [NSString stringWithFormat:@"All DKSH"]];
    [typeList addObject: [NSString stringWithFormat:@"All Unlinked"]];

    
    //access database to get hospital name
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    FMResultSet *results = [database executeQuery:@"select hospital_name from txn_hospital"];
    //NSMutableString *hospitalName = [[NSMutableString alloc]init];
    
    
    while([results next]) 
    {
        //hospitalName = [results stringForColumn: @"hospital_name"];
        NSString *hospitalName = [results stringForColumn: @"hospital_name"];
        //[hospitalName setString:[results stringForColumn: @"hospital_name"]];
        [typeList addObject: [NSString stringWithFormat: @"%@", hospitalName]];
        
        //[NSString stringWithFormat: @"%@",playerName]]
    }  

    [database close];
    //[hospitalName release];
    
    return typeList;
}

// get all customer list (CustomerList Object) on rootview controller

- (NSMutableArray*)getCustometListByType:(NSString*) type{
    
    type = [type stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSMutableArray *customerListArray = [[NSMutableArray alloc]init ];
    
    
    
    if([type isEqualToString: @"Today"] ) {
        
        FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
        
        [database open];
        
        FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT Txn_customer.profile_code, Txn_customer.cust_tname,Txn_customer.cust_fname, Txn_customer.cust_lname,Txn_customer_business.grade_code, dst_customer.kunnr, txn_customer.is_active FROM Txn_call INNER JOIN Txn_call_customer ON Txn_call.call_no = Txn_call_customer.call_no INNER JOIN Txn_customer ON Txn_call_customer.profile_code = Txn_customer.profile_code INNER JOIN Txn_customer_business ON Txn_customer.profile_code = Txn_customer_business.profile_code  left outer join dst_customer on ( txn_customer.customer_code1) = dst_customer.kunnr WHERE (julianday(Txn_call.call_date)) =(julianday('now')) AND (Txn_customer_business.business_code in (SELECT business_code FROM mst_territory where territory_code = '%@' ))AND (Txn_customer.is_active = 'Y') ORDER BY Txn_customer.profile_code", [[MJUtility sharedInstance]getMJConfigInfo:@"TerritoryCode"]]];
        
        while([results next]) 
            
        {
                CustomerList *custList = [[CustomerList alloc] init];
            //cusList            //hospitalName = [results stringForColumn: @"hospital_name"];
                custList.profileCode = [results stringForColumn: @"profile_code"];
            
                custList.name = [NSString stringWithFormat: @"%@ %@ %@",[results stringForColumn: @"cust_tname"] ,[results stringForColumn: @"cust_fname"] ,[results stringForColumn: @"cust_lname"]]; 
            
                if([[results stringForColumn: @"is_active"] isEqualToString:@"Y"])
                custList.isActive = TRUE;
                else custList.isActive = FALSE;
            
                custList.grade = [results stringForColumn: @"grade_code"];
                custList.customerCode = [results stringForColumn:@"kunnr"];
            
                [customerListArray addObject: custList];
                [custList release];
        }  
        
        [database close];
        
    }else if ([type isEqualToString: @"All Profile"] ){
        
        FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
        
        [database open];
        
        FMResultSet *results = [database executeQuery:@"SELECT A.profile_code , A.cust_tname , A.cust_fname , A.cust_lname , dc.kunnr , MIN(B.grade_code) AS grade, A.is_active FROM txn_customer A INNER JOIN txn_customer_business B ON A.PROFILE_CODE = B.PROFILE_CODE INNER JOIN mst_territory C ON B.territory_name = C.territory_name LEFT OUTER JOIN dst_customer dc ON A.customer_code1 = dc.kunnr WHERE A.IS_ACTIVE = 'Y' AND SUBSTR(A.profile_code,1,2) <> 'T_' AND A.profile_code NOT IN ( SELECT DISTINCT txn_no FROM txn_list WHERE txn_list.type = 'CU' AND SUBSTR(txn_no,0,4) IN (SELECT C.territory_code FROM mst_territory C WHERE B.TERRITORY_NAME = C.territory_name AND C.IS_ACTIVE = 'Y') AND txn_status = 'S') GROUP BY A.profile_code , A.customer_code1 , A.cust_fname , A.cust_lname , B.business_code , B.territory_name, B.grade_code , dc.kunnr ORDER BY A.cust_fname, B.grade_code"];
        
        while([results next]) 
            
        {
            CustomerList *custList = [[CustomerList alloc] init];
            //cusList            //hospitalName = [results stringForColumn: @"hospital_name"];
            custList.profileCode = [results stringForColumn: @"profile_code"];
            
            custList.name = [NSString stringWithFormat: @"%@ %@ %@",[results stringForColumn: @"cust_tname"] ,[results stringForColumn: @"cust_fname"] ,[results stringForColumn: @"cust_lname"]]; 
            
            if([[results stringForColumn: @"is_active"] isEqualToString:@"Y"])
                custList.isActive = TRUE;
            else custList.isActive = FALSE;
            
            custList.grade = [results stringForColumn: @"grade"];
            custList.customerCode = [results stringForColumn:@"kunnr"];
            
            [customerListArray addObject: custList];
            [custList release];
        }  
        
        [database close];
        
    }else if ([type isEqualToString: @"All DKSH"] ){
        
        FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
        
        [database open];
        
        FMResultSet *results = [database executeQuery:@" SELECT kunnr, tname FROM Dst_customer WHERE SUBSTR(tsort,1,6) <> 'DELETE' AND kunnr NOT IN (select kunn2 FROM dst_customer_shipto)AND SUBSTR(kunnr,1,3) NOT IN ('171','172')  ORDER BY tsort"];
        
        while([results next]) 
            
        {
            CustomerList *custList = [[CustomerList alloc] init];
            
            
            
            custList.name = [results stringForColumn: @"tname"]; 
        
            custList.isActive = FALSE;
            
            
            custList.customerCode = [results stringForColumn:@"kunnr"];
            
            [customerListArray addObject: custList];
            [custList release];
        }  
        
        [database close];
       
    
    }else if ([type isEqualToString: @"All Unlinked"] ){
        
    }else{
       

        
        //Customer by Hospital
        
        FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
        
        [database open];
        
        FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @" SELECT A.profile_code,A.cust_tname,A.cust_fname,A.cust_lname,MIN(B.grade_code) AS grade ,dc.kunnr ,A.is_active FROM   TXN_CUSTOMER A INNER JOIN TXN_CUSTOMER_BUSINESS B ON  A.PROFILE_CODE = B.PROFILE_CODE INNER JOIN Txn_customer_addr tca ON  tca.profile_code = a.profile_code AND tca.address_type = '3' AND tca.seq = '1' INNER JOIN Txn_hospital th ON  th.hospital_code = tca.hospital_code LEFT OUTER JOIN dst_customer dc ON  A.customer_code1 = dc.kunnr WHERE  A.IS_ACTIVE = 'Y'  AND SUBSTR(A.profile_code ,1 ,2) <> 'T_' AND A.profile_code NOT IN (SELECT DISTINCT txn_no FROM   txn_list WHERE  txn_list.type = 'CU' AND SUBSTR(txn_no ,0 ,3) = '%@' AND txn_status = 'S') AND th.hospital_name = '%@' GROUP BY A.profile_code,A.customer_code1,A.cust_fname,A.cust_lname,B.grade_code,dc.kunnr ORDER BY  A.cust_fname ,B.grade_code",[[MJUtility sharedInstance] getMJConfigInfo:@"TerritoryCode"], type ]];
        
        while([results next]) 
            
        {
            CustomerList *custList = [[CustomerList alloc] init];
            //cusList            //hospitalName = [results stringForColumn: @"hospital_name"];
            custList.profileCode = [results stringForColumn: @"profile_code"];
            
            custList.name = [NSString stringWithFormat: @"%@ %@ %@",[results stringForColumn: @"cust_tname"] ,[results stringForColumn: @"cust_fname"] ,[results stringForColumn: @"cust_lname"]]; 
            
            if([[results stringForColumn: @"is_active"] isEqualToString:@"Y"])
                custList.isActive = TRUE;
            else custList.isActive = FALSE;
            
            custList.grade = [results stringForColumn: @"grade"];
            custList.customerCode = [results stringForColumn:@"kunnr"];
            

            
            [customerListArray addObject: custList];
            [custList release];
        }  
        
        [database close];
    
        
        
    }
    
    
    return customerListArray;
    
}

- (Customer*)getCustomerDetailbyProfileCode:(NSString*) profileCode{
    
    Customer *customer = [[Customer alloc] init];
    
    //fetch Customer deatail From Database
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT photo,ocup_code, cust_tname, cust_fname, cust_lname, profile_code, customer_code1,customer_code2,customer_code3,email,phone,sex, bdate, idno,latitude,longitude, Position_date, edu_level_code, edu_major_code, edu_place_code, marry_status_code, spouse_tname, spouse_fname, spouse_lname, spouse_bdate,hhi_code,edc_date from txn_customer WHERE is_active = 'Y' AND profile_code = '%@' ", profileCode]];
    

    while([results next]) 
        
    {   
        
        customer.pic= [results dataForColumn: @"photo"];
        //NSString *ocup_code = [results stringForColumn:@"ocup_code"];
        customer.role = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_occupation" resultColumn:@"ocup_name" codeColumn: @"ocup_code" code:[results stringForColumn:@"ocup_code"]];
        customer.profileCode = [results stringForColumn: @"profile_code"];
        customer.titleName = [results stringForColumn: @"cust_tname"];
        customer.firstName = [results stringForColumn: @"cust_fname"];
        customer.lastName = [results stringForColumn: @"cust_lname"];
        customer.customerCode1 = [results stringForColumn: @"customer_code1"];
        customer.customerCode2 = [results stringForColumn: @"customer_code2"];
        customer.customerCode3 = [results stringForColumn: @"customer_code3"];
        customer.email = [results stringForColumn: @"email" ];
        customer.telephone = [results stringForColumn:@"phone"];
        customer.sex = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_sex" resultColumn:@"sex_name" codeColumn: @"sex_code" code:[results stringForColumn:@"sex"]];
        customer.birthDay = [[MJUtility sharedInstance] convertStringDateToNSDate:[results stringForColumn: @"bdate"]];
        //NSLog([NSString stringWithFormat: @" %@",[results stringForColumn:@"bdate"]]);
        customer.idNumber = [results stringForColumn:@"idno"];
        customer.latitude = [results stringForColumn:@"latitude"];
        customer.longtitude = [results stringForColumn: @"longitude"];
        customer.gpsupdateDate = [[MJUtility sharedInstance]convertStringDateToNSDate:[results stringForColumn: @"Position_date"]];
       customer.educationLevel = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_edu_level" resultColumn:@"edu_level_name" codeColumn: @"edu_level_code" code:[results stringForColumn:@"edu_level_code"]];
        customer.educationMajor = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_edu_major" resultColumn:@"edu_major_name" codeColumn: @"edu_major_code" code:[results stringForColumn:@"edu_major_code"]];
        customer.educationPlace = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_edu_place" resultColumn:@"edu_place_name" codeColumn: @"edu_place_code" code:[results stringForColumn:@"edu_place_code"]];
        
        customer.maritialStat = [[MJUtility sharedInstance] getPicklistValueFromTable: @"mst_marry_status" resultColumn:@"marry_status_name" codeColumn: @"marry_status_code" code:[results stringForColumn:@"marry_status_code"]];
        customer.spouseTitleName = [results stringForColumn:@"spouse_tname"];
        customer.spouseFirstName = [results stringForColumn:@"spouse_fname"];
         customer.spouseLastName = [results stringForColumn:@"spouse_lname"];
        customer.spousebirthdate = [[MJUtility sharedInstance] convertStringDateToNSDate:[results stringForColumn:@"spouse_bdate"]];
       customer.hhIncome = [[MJUtility sharedInstance] getPicklistValueFromTable: @"mst_house_hold_income" resultColumn:@"hhi_name" codeColumn: @"hhi_code" code:[results stringForColumn:@"hhi_code"]];
        
        customer.EDC = [[MJUtility sharedInstance]convertStringDateToNSDate:[results stringForColumn: @"edc_date"]];
    }  
    results = [database executeQuery:[NSString stringWithFormat: @"SELECT addr1, addr2, sub_district, district, province, zip,  phone,    phone_ext, fax, contact_time from txn_customer_addr where address_type = 1 AND profile_code = '%@' ", profileCode]];
    //get home info
    
    while([results next]) 
        
    {   
        customer.homeAddress1 = [results stringForColumn:@"addr1"];
        customer.homeAddress2 = [results stringForColumn:@"addr2"];
        customer.homeSubDistrict = [results stringForColumn:@"sub_district"];
        customer.homeDistrict = [results stringForColumn:@"district"];
        customer.homeProvince = [[MJUtility sharedInstance] getPicklistValueFromTable: @"mst_province" resultColumn:@"province_name" codeColumn: @"province_code" code:[results stringForColumn:@"province"]];
        customer.homeZip = [results stringForColumn:@"zip"];
        customer.homePhone = [results stringForColumn:@"phone"];
        customer.homeExt = [results stringForColumn:@"phone_ext"];
        customer.homefax = [results stringForColumn:@"fax"];
        customer.homeConvenienceTime = [results stringForColumn:@"contact_time"];

      // get clinic info  
    }  
    results = [database executeQuery:[NSString stringWithFormat: @"SELECT addr1, addr2, sub_district, district, province, zip,  phone,    phone_ext, fax, contact_time from txn_customer_addr where address_type = 2 AND profile_code = '%@' ", profileCode]];
    
    
    while([results next]) 
        
    {   
        customer.clinicAddress1 = [results stringForColumn:@"addr1"];
        customer.clinicAddress2 = [results stringForColumn:@"addr2"];
        customer.clinicSubDistrict = [results stringForColumn:@"sub_district"];
        customer.clinicDistrict = [results stringForColumn:@"district"];
        customer.clinicProvince = [[MJUtility sharedInstance] getPicklistValueFromTable: @"mst_province" resultColumn:@"province_name" codeColumn: @"province_code" code:[results stringForColumn:@"province"]];
        customer.clinicZip = [results stringForColumn:@"zip"];
        customer.clinicPhone = [results stringForColumn:@"phone"];
        customer.clinicExt = [results stringForColumn:@"phone_ext"];
        customer.clinicfax = [results stringForColumn:@"fax"];
        customer.clinicConvenienceTime = [results stringForColumn:@"contact_time"];
        
    }  

    // get business and ses info.
    
    results = [database executeQuery:[NSString stringWithFormat: @"SELECT txn_customer_business.business_code FROM txn_customer_business WHERE txn_customer_business.profile_code ='%@' ", profileCode]];
    
    customer.emerald = FALSE;
    customer.sapphire = FALSE;
    while([results next]) 
        
    {   NSString* temp1 = [results stringForColumn:@"business_code"];
        if([temp1 isEqualToString:@"01"])
        {
            customer.emerald = TRUE;
        }else if ([temp1 isEqualToString:@"02"]){
            customer.sapphire = TRUE;
        }
        
        
    }  
    
    results = [database executeQuery:[NSString stringWithFormat: @"SELECT txn_customer_ses.ses_code FROM txn_customer_ses WHERE profile_code ='%@' ", profileCode]];
    
    customer.high = FALSE;
    customer.medium = FALSE;
    customer.low = FALSE;
    
    while([results next]) 
        
    {   
        NSString* temp2 = [results stringForColumn:@"ses_code"];
        if([temp2 isEqualToString:@"01"])
        {
            customer.high = TRUE;
        }else if ([temp2 isEqualToString:@"02"]){
            customer.medium = TRUE;
        }else if ([temp2 isEqualToString:@"03"]){
            customer.low = TRUE;
        }
        
    }  


    
    [database close];
    // testing 
    NSLog(@"name %@", customer.firstName);
     //NSLog(@" %@", [customer. description]);
  NSLog(@"name %@", customer.titleName);
     NSLog(@" name %@", customer.firstName);
     NSLog(@" name %@", customer.lastName);
     NSLog(@" role %@", customer.role);
    
     NSLog(@"profile %@", customer.profileCode);
     NSLog(@" cuscode1%@", customer.customerCode1);
     NSLog(@" %@", customer.customerCode2);
     NSLog(@" %@", customer.customerCode3);
     NSLog(@" email %@", customer.email);
     NSLog(@" tel %@", customer.telephone);
     NSLog(@" sexx%@", customer.sex);
     NSLog(@"  bd%@", [customer.birthDay description]);
     NSLog(@" idno%@", customer.idNumber);
     NSLog(@" lat%@", customer.latitude);
     NSLog(@" long%@", customer.longtitude);
     NSLog(@" gps%@", [customer.gpsupdateDate description]);
     NSLog(@" edu%@", customer.educationLevel);
     NSLog(@"  educationmaj%@", customer.educationMajor);
     NSLog(@" place%@", customer.educationPlace);
 NSLog(@"maritial %@", customer.maritialStat);
     NSLog(@"spousetname %@", customer.spouseTitleName);
    NSLog(@"spousefname %@", customer.spouseFirstName);
    NSLog(@"spouselname %@", customer.spouseLastName);
    
     NSLog(@"spousebd %@", [customer.spousebirthdate description]);
    //NSString* numberOfChild;
    
     NSLog(@"hhincome %@", customer.hhIncome);
    
    // home section
     NSLog(@"homeaddress %@", customer.homeAddress1);
     NSLog(@"homeaddress2 %@", customer.homeAddress2);
     NSLog(@"homesubdistrict %@", customer.homeSubDistrict);
     NSLog(@"home district %@", customer.homeDistrict);
     NSLog(@" %@", customer.homeProvince);
    NSLog(@" %@", customer.homeZip);
    NSLog(@" %@", customer.homePhone);
    NSLog(@" %@", customer. homeExt);
    NSLog(@" %@", customer.homefax);
     NSLog(@" %@", customer.homeConvenienceTime);
    
    //clinic section
    
    
    NSLog(@" %@", customer.clinicAddress1);
     NSLog(@" %@", customer.clinicAddress2);
     NSLog(@" %@", customer.clinicSubDistrict);
 NSLog(@" %@", customer.clinicDistrict);
     NSLog(@" %@", customer.clinicProvince);
 NSLog(@" %@", customer.clinicZip);
 NSLog(@" %@", customer.clinicPhone);
   NSLog(@" %@", customer. clinicExt);
  NSLog(@" %@", customer.clinicfax);
 NSLog(@" %@", customer. clinicConvenienceTime);
    
    if(customer.emerald)
        NSLog(@" emerald Y");
    if(customer.sapphire)
        NSLog(@" sapphire Y");
        
    if(customer.high)
        NSLog(@" high Y");
    if(customer.medium)
        NSLog(@" medium Y");
    if(customer.low)
        NSLog(@" low Y");
    
    /*
    // Business
    BOOL emerald;
    BOOL sapphire;
    // SES
    BOOL high;
    BOOL medium;
    BOOL low;
    */
    // EDC
     NSLog(@" %@", [customer.EDC description]);

    
    return customer;
}

- (NSMutableArray*) getAllCustomerChildren: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
     [database open];

    NSMutableArray *childArray = [[NSMutableArray alloc]init ];
    
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT child_no, child_tname, child_fname, child_lname, sex, bdate FROM txn_child where profile_code = '%@' ", profileCode]];
    
    while([results next]) 
        
    {
        CustomerChild *child = [[CustomerChild alloc] init];
        //cusList            //hospitalName = [results stringForColumn: @"hospital_name"];
        child.number = [results stringForColumn: @"child_no"];
        child.titleName = [results stringForColumn: @"child_tname" ];
         child.firstName = [results stringForColumn: @"child_fname" ];    
         child.lastName = [results stringForColumn: @"child_lname" ];
          child.birthDate = [[MJUtility sharedInstance]convertStringDateToNSDate:[results stringForColumn: @"bdate"]];
        child.sex = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_sex" resultColumn:@"sex_name" codeColumn: @"sex_code" code:[results stringForColumn:@"sex"]];

        [childArray addObject: child];
        [child release];
    }  
    [database close];
    return childArray;
    
        
}

- (NSMutableArray*) getAllHobbies: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
     [database open];
    NSMutableArray *hobbyArray = [[NSMutableArray alloc]init ];
    
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT b.lifestyle_name ,a.description from  txn_customer_lifestyle a, Mst_lifestyle b  WHERE b.lifestyle_code = a.lifestyle_code AND a.profile_code = '%@' ", profileCode]];
    
    while([results next]) 
        
    {
        Hobby *hobby = [[Hobby alloc] init];
        //cusList            //hospitalName = [results stringForColumn: @"hospital_name"];
        hobby.name = [results stringForColumn: @"lifestyle_name"];
      
        hobby.description = [results stringForColumn: @"description"];

        
        [hobbyArray addObject: hobby];
        [hobby release];
    }  
    [database close];
    return hobbyArray;
    
    
}

// get all customer member return in form of Array of CustomerMember

- (NSMutableArray*) getAllMembers: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
     [database open];
    NSMutableArray * array = [[NSMutableArray alloc]init ];
    
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT member_no, member_name,end_date, begin_date  FROM Txn_customer_member cm inner join Mst_member c on cm.member_code=c.member_code where  cm.profile_code= '%@'and c.Full_info_required ='Y' Order by cm.member_no ", profileCode]];
    
    while([results next]) 
        
    {
        CustomerMember *member = [[CustomerMember alloc] init];
        
        member.number = [results stringForColumn: @"member_no"];
        member.name = [results stringForColumn: @"member_name"];
        member.endDate = [[MJUtility sharedInstance] convertStringDateToNSDate:[results stringForColumn: @"end_date"]];  
        
   member.beginDate = [[MJUtility sharedInstance] convertStringDateToNSDate:[results stringForColumn: @"begin_date"]]; 
        
         
        [array addObject: member];
        [member release];
    }  
    [database close];
    
    return array;
    
}



- (NSMutableArray*) getAllWorkPlaces: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
     [database open];
    NSMutableArray * array = [[NSMutableArray alloc]init ];
    
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT  hospital_name, department_name, building, contact_time from txn_customer_addr LEFT OUTER JOIN Mst_department ON mst_department.department_code = txn_customer_addr.department_code LEFT OUTER JOIN txn_hospital ON txn_hospital.hospital_code = txn_customer_addr.hospital_code where address_type = 3 AND txn_customer_addr.profile_code = '%@' ORDER BY seq" , profileCode]];
    
    while([results next]) 
        
    {
        CustomerWorkPlace *wp = [[CustomerWorkPlace alloc] init];
        
        wp.hospitalName = [results stringForColumn: @"hospital_name"];
        wp.department = [results stringForColumn: @"department_name"];
        wp.building = [results stringForColumn: @"building"];
        wp.workTime = [results stringForColumn: @"contact_time"];
        
        
        [array addObject: wp];
        [wp release];
    }  
    [database close];
    return array;
    
    
}

// Get All patient type to initialize label, return in form of array of CustomerPatient

- (NSMutableArray*) getAllPatientTypeLabel{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [[NSMutableArray alloc]init ];
    
    
    FMResultSet *results = [database executeQuery:@"SELECT  patient_type_name from mst_patient_type  ORDER BY patient_type_code"];
    
    while([results next]) 
        
    {
        CustomerPatient *cp = [[CustomerPatient alloc] init];
        
        cp.type = [results stringForColumn: @"patient_type_name"];
        cp.totalBirth = @"0";
        cp.totalCommercial = @"0";
        
        
        [array addObject: cp];
        [cp release];
    } 
    [database close];
    return array;
    
    
}

// get real record to update the list, return in form of araay of CustomerPatient
- (NSMutableArray*) getAllPatientType: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [self getAllPatientTypeLabel];    
    //NSMutableArray * arrayLabel = [self getAllPatientTypeLabel];
    NSString* typeTemp;
    NSString* totalBirthTemp;
    NSString* totalCommercialTemp;
    
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT  patient_type_name , total_commercial , total_potential from mst_patient_type  LEFT OUTER JOIN txn_customer_patient ON txn_customer_patient.patient_type_code = mst_patient_type.patient_type_code  where txn_customer_patient.profile_code = '%@' ORDER BY  mst_patient_type.patient_type_code" , profileCode]];
    
    while([results next]) 
        
    {   
       // CustomerPatient *cp = [[CustomerPatient alloc] init];
     //   NSEnumerator * enumerator = [array objectEnumerator];
      //  CustomerPatient *cp = [[CustomerPatient alloc] init];
        
        typeTemp = [results stringForColumn: @"patient_type_name"];
        totalBirthTemp = [results stringForColumn: @"total_potential"];
        totalCommercialTemp  = [results stringForColumn: @"total_commercial"];

        for (CustomerPatient *cp in array) {
            
            
            if ([cp.type isEqualToString:typeTemp])
            {
                cp.totalBirth = totalBirthTemp;
                cp.totalCommercial =  totalCommercialTemp;
            }
            
        }
                    

    } 
    
    
    [database close];
    //[typeTemp release];
    //[totalBirthTemp release];
    //[totalCommercialTemp release];
    
    
    return array;
    
    
}

//////// get real record to update the list, return in form of Customer Status

- (CustomerStatus*) getAllStatus: (NSString*) profileCode{
   
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
   // NSMutableArray * array = [[NSMutableArray alloc]init ];
    
    CustomerStatus *cp = [[CustomerStatus alloc] init];
    cp.Recommender = FALSE;
    cp.RoCommPTC = FALSE;
    cp.DepartmentHead = FALSE;
    cp.KOL= FALSE;
    cp.EndUseer = FALSE;
    cp.DirecAsstDirec = FALSE;
    cp.PedOBNurse = FALSE;
    cp.PedOBDoctor = FALSE;
    cp.Depo = FALSE;
    cp.PregList = FALSE;
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT status_code from txn_customer_status  where profile_code ='%@' ORDER BY status_code" , profileCode]];
    NSString* temp1;
    
    while([results next]) 
        
    {
        temp1 = [results stringForColumn: @"status_code"];
        
        if([temp1 isEqualToString:@"01"]){
            cp.Recommender = TRUE;
        }else if ([temp1 isEqualToString:@"02"]){
            cp.RoCommPTC = TRUE;
        }else if ([temp1 isEqualToString:@"03"]){
            cp.DepartmentHead = TRUE;
        }else if ([temp1 isEqualToString:@"04"]){
            cp.KOL = TRUE;
        }else if ([temp1 isEqualToString:@"05"]){
            cp.EndUseer = TRUE;
        }else if ([temp1 isEqualToString:@"06"]){
            cp.DirecAsstDirec = TRUE;
        }else if ([temp1 isEqualToString:@"07"]){
            cp.PedOBNurse = TRUE;
        }else if ([temp1 isEqualToString:@"08"]){
            cp.PedOBDoctor = TRUE;
        }else if ([temp1 isEqualToString:@"09"]){
            cp.Depo = TRUE;
        }else if ([temp1 isEqualToString:@"10"]){
            cp.PregList = TRUE;
        }
            
          
                
    }
    //[temp1 release];
    [database close];
    return cp;

    
}

// Get All Product Brand Label to initialize label, return in form of Arrray of NSString.

- (NSMutableArray*) getAllProductBrandLabel {
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [[NSMutableArray alloc]init ];
        
    FMResultSet *results = [database executeQuery:@"SELECT DISTINCT mpb.prod_brand_name,mpb.prod_brand_code  FROM mst_product_brand mpb INNER JOIN Mst_patient_type mpt ON mpb.patient_type_code = mpt.patient_type_code WHERE mpb.is_recomment = 'Y' ORDER BY mpb.patient_type_code ASC "];
    
    while([results next]) 
        
    {
        CustomerProduct *cp = [[CustomerProduct alloc]init];  
        cp.name = [results stringForColumn:@"prod_brand_name"];
        cp.code = [results stringForColumn:@"prod_brand_code"];
        cp.recQty = @"0";
        
        [array addObject:cp];
          [cp release];
    } 
    
    [database close];
    return array;
    
    
}
//////// return in form of Array of CustomerProduct 

- (NSMutableArray*) getAllProductBrand:(NSString*) profileCode 
{    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [self getAllProductBrandLabel];
   // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT TRIM(prod_brand_code) ,recommended_qty from txn_customer_product WHERE profile_code = '%@'", profileCode]];
    NSString *temp1;     
    NSString *temp2;  
    while([results next]) 
        
    {
         temp1 = [results stringForColumn:@"prod_brand_code"];
         temp2 = [results stringForColumn:@"recommended_qty"];
         //temp1 = [temp1 stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
         //temp2 = [temp2 stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        for(CustomerProduct *cp in array)
        {
            if([[NSString stringWithFormat:@"%@", temp1] isEqualToString: cp.code])
                cp.recQty  = temp2;
        }
        
    } 
  //  [temp1 release];
    //[temp2 release];
    [database close];
    
    return array;
    
    

    
}
//*********************************** Pick List Value **************************************************

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListTitleName{
    
   
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
        [database open];
        NSMutableArray * array = [NSMutableArray array];
        // =      NSString *temp2 = [[NSString alloc] init];                       
        
        FMResultSet *results = [database executeQuery:@"SELECT tname FROM mst_title_name"];
        
        while([results next]) 
            
        {
             [array addObject:[results stringForColumn:@"tname"]];
            
            
        } 
        
        [database close];
         
        return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListRoleName{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

 //   NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT ocup_name FROM mst_occupation ORDER BY ocup_code"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"ocup_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListEduLevelName{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

  //  NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT edu_level_name FROM mst_edu_level"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"edu_level_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}
// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListEduMajorName{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT edu_major_name FROM mst_edu_major"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"edu_major_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListEduPlaceName{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

    
    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT edu_place_name FROM mst_edu_place"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"edu_place_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListMaritialStatName{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

  //  NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT marry_status_name FROM mst_marry_status"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"marry_status_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListHHIncomeName{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT hhi_name FROM mst_house_hold_income"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"hhi_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}


// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListProvince{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

   // NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT province_name FROM mst_province ORDER BY province_name"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"province_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListSex{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

   // NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT sex_name FROM mst_sex"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"sex_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListHobbies{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT lifestyle_name FROM mst_lifestyle"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"lifestyle_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListHospital{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

   // NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT hospital_name FROM txn_hospital"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"hospital_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return All picklist value in Array of NSString
- (NSMutableArray*) getAllPickListDepartment{
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT department_name FROM mst_department"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"department_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}



//************************************* Call history ***********************************
// return in form of Array of CallHistory
-(NSMutableArray*) getAllCallHistory: (NSString* )profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];

  //  NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       

    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"select tc.call_no, tc.call_date , tccp.call_product_code, tccp.call_objective_code ,tccp.call_result_code, tccp.call_complaint_code, tccp.call_sample , tcc.remark FROM txn_call_customer_product tccp, txn_call_customer tcc , txn_call tc WHERE tc.call_no = tcc.call_no AND tcc.call_no = tccp.call_no AND tcc.seq = tccp.seq AND tcc.profile_code = '%@' AND tcc.is_visit = 'Y'",profileCode ]];
    
    while([results next]) 
        
    {   CallHistory *callhist = [[CallHistory alloc] init];
        callhist.number = [results stringForColumn:[NSString stringWithFormat:@"call_no"]];
        callhist.date = [results stringForColumn:[NSString stringWithFormat:@"call_date"]];
        callhist.product = [results stringForColumn:[NSString stringWithFormat:@"call_product_code"]];
    
        callhist.objective = [results stringForColumn:[NSString stringWithFormat:@"call_objective_code"]];
        callhist.result =   [results stringForColumn:[NSString stringWithFormat:@"call_result_code"]];
        callhist.complaint = [results stringForColumn:[NSString stringWithFormat:@"call_complain_code"]];
        callhist.sample = [results stringForColumn:[NSString stringWithFormat:@"call_sample"]];
        callhist.remark = [results stringForColumn:[NSString stringWithFormat:@"remark"]];

        [array addObject: callhist];
        
        [callhist release];
    }
 
    for(CallHistory *ch in array){
        ch.product = [database stringForQuery:[NSString stringWithFormat:@"select prod_brand_name from mst_product_brand Where prod_brand_code = '%@'",ch.product]];
        ch.objective = [database stringForQuery:[NSString stringWithFormat:@"select call_objective_name from mst_call_objective Where call_objective_code = '%@'",ch.objective]];
        ch.result = [database stringForQuery:[NSString stringWithFormat:@"select call_result_name from mst_call_result Where call_result_code = '%@'",ch.result]];
        ch.complaint = [database stringForQuery:[NSString stringWithFormat:@"select call_complaint_name from mst_call_complaint Where call_complaint_code = '%@'",ch.complaint]];
    
        
    }
     
       [database close];
    return array;
}


//************************************* Sales history ***********************************
// return in form of Array of SalesHistory
-(NSMutableArray*) getAllSalesHistoryInvoice: (NSString* )custCode1 and: (NSString* )custCode2  and:(NSString* )custCode3 {
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];
    
    //  NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT docdate,ordno,edesc,qty,price, free,netwr FROM dst_orderdaily, dst_product WHERE TRIM(dst_product.matnr) = TRIM(dst_orderdaily.prdcode) AND TRIM(cuscode)  in ('%@','%@', '%@') ORDER BY docdate DESC ",custCode1,custCode2,custCode3 ]];
    
    while([results next]) 
        
    {   SalesHistory *saleshist = [[SalesHistory alloc] init];
        
        saleshist.number = [results stringForColumn:[NSString stringWithFormat:@"ordno"]];
        saleshist.date = [results stringForColumn:[NSString stringWithFormat:@"docdate"]];
        saleshist.product = [results stringForColumn:[NSString stringWithFormat:@"edesc"]];
        saleshist.unitPrice = [results stringForColumn:[NSString stringWithFormat:@"price"]];
        saleshist.quantity = [results stringForColumn:[NSString stringWithFormat:@"qty"]];
        saleshist.amount =   [results stringForColumn:[NSString stringWithFormat:@"netwr"]];
        saleshist.free = [results stringForColumn:[NSString stringWithFormat:@"free"]];
      //  saleshist.sample = [results stringForColumn:[NSString stringWithFormat:@"call_sample"]];
      //  saleshist.remark = [results stringForColumn:[NSString stringWithFormat:@"remark"]];
        
        [array addObject: saleshist];
        
        [saleshist release];
    }
    
     
    [database close];
    return array;
}
// return in form of Array of SalesHistory
-(NSMutableArray*) getAllSalesHistoryBackOrder: (NSString* )custCode1 and: (NSString* )custCode2  and:(NSString* )custCode3 {
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];
    
    //  NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT docdate,ordno,edesc,qty,price, free,netwr,TRIM(relate) FROM dst_backorder, dst_product WHERE TRIM(dst_product.matnr) = TRIM(dst_backorder.prdcode) AND TRIM(cuscode)  in ('%@','%@', '%@') ORDER BY docdate DESC ",custCode1,custCode2,custCode3 ]];
    
    while([results next]) 
        
    {   SalesHistory *saleshist = [[SalesHistory alloc] init];
        
        saleshist.number = [results stringForColumn:[NSString stringWithFormat:@"ordno"]];
        saleshist.date = [results stringForColumn:[NSString stringWithFormat:@"docdate"]];
        saleshist.product = [results stringForColumn:[NSString stringWithFormat:@"edesc"]];
        saleshist.unitPrice = [results stringForColumn:[NSString stringWithFormat:@"price"]];
        saleshist.quantity = [results stringForColumn:[NSString stringWithFormat:@"qty"]];
        saleshist.amount =   [results stringForColumn:[NSString stringWithFormat:@"netwr"]];
        saleshist.free = [results stringForColumn:[NSString stringWithFormat:@"free"]];
        saleshist.reason = [results stringForColumn:[NSString stringWithFormat:@"relate"]];
        //  saleshist.sample = [results stringForColumn:[NSString stringWithFormat:@"call_sample"]];
        //  saleshist.remark = [results stringForColumn:[NSString stringWithFormat:@"remark"]];
        
        [array addObject: saleshist];
        
        [saleshist release];
    }
    for(SalesHistory *ch in array){
        ch.reason = [database stringForQuery:[NSString stringWithFormat:@"select reason_name from mst_foc_reason Where reason_code = '%@' WHERE active = 'Y'",ch.reason]];
        
    }
    
    
    [database close];
    return array;
}

@end