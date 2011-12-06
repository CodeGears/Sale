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

static CustomerDataHandler* _sharedInstance = nil;

#pragma mark- Singleton method
+ (id) sharedInstance{
    @synchronized(self){
        if (_sharedInstance == nil) {
            _sharedInstance = [[[self class] alloc] init];
            
        }
    }
    return _sharedInstance;
}


-(void)dealloc{
    
    [_sharedInstance release];
    [super dealloc];
}



#pragma mark- Customer Detail Get Method
//Get All customer Type send back Array of TypeName 

- (NSMutableArray*)getAllCustomerType
{   
    NSMutableArray *typeList = [NSMutableArray array] ;
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
    
    NSMutableArray *customerListArray = [NSMutableArray array];
    
    
    
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
     NSLog(@"EDC %@", [customer.EDC description]);
    NSLog(@"NEW %@",[[MJUtility sharedInstance] getMJConfigInfo:@"TerritoryCode"]);
    NSLog(@"NEW %@",[[[MJUtility sharedInstance] getMJConfigInfo:@"TerritoryCode"] 
                     stringByAppendingFormat: @"%@",customer.hhIncome]);
    return customer;
}

- (NSMutableArray*) getAllCustomerChildren: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
     [database open];

    NSMutableArray *childArray = [NSMutableArray array];
    
    
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
    NSMutableArray *hobbyArray = [NSMutableArray array];
    
    
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
    NSMutableArray * array = [NSMutableArray array];
    
    
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
    NSMutableArray * array = [NSMutableArray array];
    
    
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
    NSMutableArray * array = [NSMutableArray array];
    
    
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
   // NSMutableArray * array = [NSMutableArray array];
    
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
    NSMutableArray * array = [NSMutableArray array];
        
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
         temp1 = [results stringForColumn:@"TRIM(prod_brand_code)"];
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


#pragma mark-  Customer Detail PickList Value
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
- (NSMutableArray*) getAllPickListHospitalfor:(NSString*) profileCode
{
    
    
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
    results = [database executeQuery:[NSString stringWithFormat: @"SELECT hospital_name FROM txn_customer_addr LEFT OUTER JOIN txn_hospital ON txn_customer_addr.hospital_code = txn_hospital.hospital_code WHERE txn_customer_addr.profile_code = '%@' AND  txn_customer_addr.address_type = 3 ",profileCode]];
    
    while([results next]) 
        
    {
        for(NSString* hn in array){
            if([hn isEqualToString:[results stringForColumn:@"hospital_name"]])
                [array removeObject:hn];
        }
        
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
        saleshist.reason = [results stringForColumn:[NSString stringWithFormat:@"TRIM(relate)"]];
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



#pragma mark- Customer Detail  update new delete method
// *****************************************Update NEW DELETE***********************************************

-(NSMutableDictionary*) updateCustomerDetail:(Customer*) customer
{
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    //check is active
    customer.customerCode1  = [customer.customerCode1 stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* kunnr = [database stringForQuery:[NSString stringWithFormat: @"SELECT kunnr FROM dst_customer WHERE TRIM(kunnr) = '%@'",customer.customerCode1]];
    
    NSString* is_active;
    if(kunnr != nil){
        is_active = @"Y";
    }else is_active = nil;
   
    customer.role = [customer.role stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.role = [database stringForQuery:[NSString stringWithFormat: @"SELECT ocup_code FROM Mst_occupation WHERE TRIM(ocup_name) = '%@'",customer.role]];
    
    customer.sex  = [customer.sex stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.sex = [database stringForQuery:[NSString stringWithFormat: @"SELECT sex_code FROM Mst_sex WHERE TRIM(sex_name) = '%@'",customer.sex]];
    
    customer.educationLevel  = [customer.educationLevel stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.educationLevel= [database stringForQuery:[NSString stringWithFormat: @"SELECT edu_level_code FROM Mst_edu_level WHERE TRIM(edu_level_name) = '%@'",customer.educationLevel]];
    
    customer.educationMajor= [customer.educationMajor stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.educationMajor= [database stringForQuery:[NSString stringWithFormat: @"SELECT edu_major_code FROM Mst_edu_major WHERE TRIM(edu_major_name) = '%@'",customer.educationMajor]];
    
    customer.educationPlace  = [customer.educationPlace stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.educationPlace= [database stringForQuery:[NSString stringWithFormat: @"SELECT edu_place_code FROM Mst_edu_place WHERE TRIM(edu_place_name) = '%@'",customer.educationPlace]];

    customer.maritialStat  = [customer.maritialStat stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.maritialStat= [database stringForQuery:[NSString stringWithFormat: @"SELECT marry_status_code FROM mst_marry_status WHERE TRIM(marry_status_name) = '%@'",customer.maritialStat]];
    
    customer.hhIncome  = [customer.hhIncome stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.hhIncome= [database stringForQuery:[NSString stringWithFormat: @"SELECT hhi_name FROM mst_house_hold_income WHERE TRIM(hhi_name) = '%@'",customer.hhIncome]];
    [database beginTransaction];
    // update customer detail 
   BOOL boolean1 = [database executeUpdate:@"update txn_customer SET photo = ? ,ocup_code = ?, cust_tname = ?, cust_fname = ? , cust_lname = ?, customer_code1 =?,customer_code2 =? ,customer_code3 = ? ,email = ?,phone = ? ,sex = ? , bdate = ? , idno =?, edu_level_code = ? , edu_major_code = ? , edu_place_code = ? , marry_status_code = ?, spouse_tname = ?, spouse_fname = ?, spouse_lname = ? , spouse_bdate = ?,hhi_code = ?,edc_date = ?, update_date = CURRENT_TIMESTAMP ,update_by = ? , is_active = ? WHERE profile_code = ?", customer.pic , customer.role,customer.titleName, customer.firstName,customer.lastName,customer.customerCode1,customer.customerCode2,customer.customerCode3, customer.email,customer.telephone ,customer.sex,[[MJUtility sharedInstance] convertNSDateToString:customer.birthDay],customer.idNumber ,customer.educationLevel,customer.educationMajor,customer.educationPlace,customer.maritialStat,customer.spouseTitleName,customer.spouseFirstName,customer.spouseLastName,[[MJUtility sharedInstance] convertNSDateToString:customer.spousebirthdate], customer.hhIncome, customer.EDC, [[MJUtility sharedInstance]getMJConfigInfo:@"SalesCode"],is_active,customer.profileCode];

    if(boolean1 == FALSE)
    {
        [database rollback];
        
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        [database close];
        
        return output;
    }
    
   

    if(customer.homeAddress1 != nil && customer.homeAddress2 != nil && customer.homeSubDistrict != nil && customer.homeDistrict != nil && customer.homeProvince  != nil &&  customer.homeZip  != nil && customer.homePhone != nil &&  customer.homeExt != nil && customer.homefax != nil && customer.homeConvenienceTime != nil )
    {
        
        
        // prep home province data
        customer.homeProvince  = [customer.homeProvince stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        customer.homeProvince = [database stringForQuery:[NSString stringWithFormat: @"SELECT province_code FROM mst_province WHERE TRIM(province_name) = '%@'",customer.homeProvince]];
        
    // update customer clinic addr 
    BOOL boolean2 = [database executeUpdate:@"update txn_customer_addr SET addr1 = ? , addr2 = ? , sub_district = ?, district= ?, province =?, zip = ? ,  phone = ?,    phone_ext = ?, fax = ?, contact_time = ?  WHERE profile_code = ? AND address_type = 1",customer.homeAddress1, customer.homeAddress2 ,customer.homeSubDistrict ,customer.homeDistrict ,customer.homeProvince , customer.homeZip,customer.homePhone,customer.homeExt,customer.homefax,customer.homeConvenienceTime, customer.profileCode];
    
    
    if(boolean2 == FALSE)
    {   [database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        [database close];
        return output;
    }
    
    }
    
    
    if(customer.clinicAddress1 != nil && customer.clinicAddress2 != nil && customer.clinicSubDistrict != nil && customer.clinicDistrict != nil && customer.clinicProvince != nil &&  customer.clinicZip!= nil && customer.clinicPhone!= nil && customer.clinicExt!= nil && customer.clinicfax!= nil && customer.clinicConvenienceTime!= nil &&  customer.profileCode){
    
    // prep clinic province data
    customer.clinicProvince  = [customer.clinicProvince stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.clinicProvince = [database stringForQuery:[NSString stringWithFormat: @"SELECT province_code FROM mst_province WHERE TRIM(province_name) = '%@'",customer.clinicProvince]];
    
    
    // update customer home addr 
    BOOL boolean3 = [database executeUpdate:@"update txn_customer_addr SET addr1 = ? , addr2 = ? , sub_district = ?, district= ?, province =?, zip = ? ,  phone = ?,    phone_ext = ?, fax = ?, contact_time = ?  WHERE profile_code = ? AND address_type = 2",customer.clinicAddress1, customer.clinicAddress2 ,customer.clinicSubDistrict ,customer.clinicDistrict ,customer.clinicProvince , customer.clinicZip,customer.clinicPhone,customer.clinicExt,customer.clinicfax,customer.clinicConvenienceTime, customer.profileCode];
    
    
    if(boolean3 == FALSE)
    {   [database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];

        [database close];
        return output;
    }
    }
    
    /*
    // prep business data to update
    NSString *emerald;
    NSString *sapphire;
    if(customer.emerald)
        emerald = @"01";
    if(customer.sapphire)
        sapphire = @"02";
    
    // update data
    BOOL boolean4 = [database executeUpdate:@"update txn_customer_business SET addr1 = ? , addr2 = ? , sub_district = ?, district= ?, province =?, zip = ? ,  phone = ?,    phone_ext = ?, fax = ?, contact_time = ?  WHERE profile_code = ? AND address_type = 2",customer.clinicAddress1, customer.clinicAddress2 ,customer.clinicSubDistrict ,customer.clinicDistrict ,customer.clinicProvince , customer.clinicZip,customer.clinicPhone,customer.clinicExt,customer.clinicfax,customer.clinicConvenienceTime, customer.profileCode];
     */
    
    
    // delete existing and insert new 
    if(customer.high || customer.medium || customer.low){
        [database executeUpdate:@"delete FROM txn_customer_ses WHERE profile_code = ?",customer.profileCode];
    
    // find max doc_num 
    
        if(customer.high){
            int maxses1 = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"]+1;
            [database executeUpdate:@"INSERT INTO txn_customer_ses(doc_num,profile_code,ses_code) VALUES (?,?,?)",[NSNumber numberWithInt: maxses1 ],customer.profileCode,@"01"];
        }
        if(customer.medium)
        {
            int maxses2 = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"]+1;
            [database executeUpdate:@"INSERT INTO txn_customer_ses(doc_num,profile_code,ses_code) VALUES (?,?,?)",[NSNumber numberWithInt: maxses2 ],customer.profileCode,@"02"];
        }
        if(customer.low){
            
            int maxses3 = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"]+1;
            
            [database executeUpdate:@"INSERT INTO txn_customer_ses(doc_num,profile_code,ses_code) VALUES (?,?,?)",[NSNumber numberWithInt: maxses3 ],customer.profileCode,@"03"];
        }

       
    }
    
    [database commit];
       
    
    [is_active release];
    
    if([[MJUtility sharedInstance] checkInTxn:customer.profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
      //  [output setObject: nil forKey:@"ErrorMsg"];
      
       
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
                
    }
    [database close];
    return output;

}

/// insert into new customer
-(NSMutableDictionary*) newCustomerDetail:(Customer*) customer
{
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];

    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    //check is active
    customer.customerCode1  = [customer.customerCode1 stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* kunnr = [database stringForQuery:[NSString stringWithFormat: @"SELECT kunnr FROM dst_customer WHERE TRIM(kunnr) = '%@'",customer.customerCode1]];
    
    NSString* is_active;
    if(kunnr != nil){
        is_active = @"Y";
    }else is_active = nil;
    
    // get last and docnum
    
    int doc_num =[database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer"]+1;
    NSString *max = [NSString stringWithFormat:@"%d",doc_num%1000] ;
    
    
    
    // generate new profile code 
    
    
   customer.profileCode = [[[MJUtility sharedInstance] getMJConfigInfo:@"TerritoryCode"] stringByAppendingFormat: @"%@",max];
    
    
    // find code from name to put info
    
    customer.role = [customer.role stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.role = [database stringForQuery:[NSString stringWithFormat: @"SELECT ocup_code FROM Mst_occupation WHERE TRIM(ocup_name) = '%@'",customer.role]];
    
    customer.sex  = [customer.sex stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.sex = [database stringForQuery:[NSString stringWithFormat: @"SELECT sex_code FROM Mst_sex WHERE TRIM(sex_name) = '%@'",customer.sex]];
    
    customer.educationLevel  = [customer.educationLevel stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.educationLevel= [database stringForQuery:[NSString stringWithFormat: @"SELECT edu_level_code FROM Mst_edu_level WHERE TRIM(edu_level_name) = '%@'",customer.educationLevel]];
    
    customer.educationMajor= [customer.educationMajor stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.educationMajor= [database stringForQuery:[NSString stringWithFormat: @"SELECT edu_major_code FROM Mst_edu_major WHERE TRIM(edu_major_name) = '%@'",customer.educationMajor]];
    
    customer.educationPlace  = [customer.educationPlace stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.educationPlace= [database stringForQuery:[NSString stringWithFormat: @"SELECT edu_place_code FROM Mst_edu_place WHERE TRIM(edu_place_name) = '%@'",customer.educationPlace]];
    
    customer.maritialStat  = [customer.maritialStat stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.maritialStat= [database stringForQuery:[NSString stringWithFormat: @"SELECT marry_status_code FROM mst_marry_status WHERE TRIM(marry_status_name) = '%@'",customer.maritialStat]];
    
    customer.hhIncome  = [customer.hhIncome stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.hhIncome= [database stringForQuery:[NSString stringWithFormat: @"SELECT hhi_name FROM mst_house_hold_income WHERE TRIM(hhi_name) = '%@'",customer.hhIncome]];
    [database beginTransaction];
    // update customer detail 
    BOOL boolean1 = [database executeUpdate:@"insert into txn_customer(doc_num,photo,ocup_code, cust_tname, cust_fname, cust_lname, customer_code1,customer_code2,customer_code3 ,email,phone,sex, bdate, idno, edu_level_code , edu_major_code, edu_place_code , marry_status_code , spouse_tname , spouse_fname , spouse_lname , spouse_bdate,hhi_code ,edc_date, record_date,record_by , is_active ,profile_code) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,CURRENT_TIMESTAMP,?,?,?)",[NSNumber numberWithInt:doc_num], customer.pic , customer.role,customer.titleName, customer.firstName,customer.lastName,customer.customerCode1,customer.customerCode2,customer.customerCode3, customer.email,customer.telephone ,customer.sex,[[MJUtility sharedInstance] convertNSDateToString:customer.birthDay] ,customer.idNumber ,customer.educationLevel,customer.educationMajor,customer.educationPlace,customer.maritialStat,customer.spouseTitleName,customer.spouseFirstName,customer.spouseLastName,[[MJUtility sharedInstance] convertNSDateToString:customer.spousebirthdate], customer.hhIncome, customer.EDC, [[MJUtility sharedInstance]getMJConfigInfo:@"SalesCode"],is_active,customer.profileCode];
    
    if(boolean1 == FALSE)
    {   [database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    
    if(customer.homeAddress1 != nil && customer.homeAddress2 != nil && customer.homeSubDistrict != nil && customer.homeDistrict != nil && customer.homeProvince  != nil &&  customer.homeZip  != nil && customer.homePhone != nil &&  customer.homeExt != nil && customer.homefax != nil && customer.homeConvenienceTime != nil )
    {
        
    
    // prep home province data
    customer.homeProvince  = [customer.homeProvince stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.homeProvince = [database stringForQuery:[NSString stringWithFormat: @"SELECT province_code FROM mst_province WHERE TRIM(province_name) = '%@'",customer.homeProvince]];
    
    
    
    // update customer clinic addr 
    BOOL boolean2 = [database executeUpdate:@"insert into txn_customer_addr(addr1, addr2, sub_district, district, province, zip ,  phone,    phone_ext, fax, contact_time, profile_code ,address_type,seq) VALUES (?,?,?,?,?,?,?,?,?,?,?,'1','0')",customer.homeAddress1, customer.homeAddress2 ,customer.homeSubDistrict ,customer.homeDistrict ,customer.homeProvince , customer.homeZip,customer.homePhone,customer.homeExt,customer.homefax,customer.homeConvenienceTime, customer.profileCode];
    
    
    if(boolean2 == FALSE)
    {   [database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    }
    
    if(customer.clinicAddress1 != nil && customer.clinicAddress2 != nil && customer.clinicSubDistrict != nil && customer.clinicDistrict != nil && customer.clinicProvince != nil &&  customer.clinicZip!= nil && customer.clinicPhone!= nil && customer.clinicExt!= nil && customer.clinicfax!= nil && customer.clinicConvenienceTime!= nil &&  customer.profileCode){
    
    
    // prep clinic province data
    customer.clinicProvince  = [customer.clinicProvince stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    customer.clinicProvince = [database stringForQuery:[NSString stringWithFormat: @"SELECT province_code FROM mst_province WHERE TRIM(province_name) = '%@'",customer.clinicProvince]];
    
    
    // update customer home addr 
    BOOL boolean3 = [database executeUpdate:@"insert into txn_customer_addr(addr1, addr2, sub_district, district, province, zip ,  phone,    phone_ext, fax, contact_time, profile_code ,address_type,seq) VALUES (?,?,?,?,?,?,?,?,?,?,?,'2','0')",customer.clinicAddress1, customer.clinicAddress2 ,customer.clinicSubDistrict ,customer.clinicDistrict ,customer.clinicProvince , customer.clinicZip,customer.clinicPhone,customer.clinicExt,customer.clinicfax,customer.clinicConvenienceTime, customer.profileCode];
    
    
    if(boolean3 == FALSE)
    {   [database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    
    }
     // insert business data
    
    BOOL boolean4;
    if(customer.emerald){
         int maxbusiness1 = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_business"]+1;
        //emerald = @"01";
        // update data
        
         boolean4 = [database executeUpdate:@"insert into txn_customer_business(doc_num,profile_code,business_code,rep_code,territory_name)VALUES (?,?,?,?,?)",[NSNumber numberWithInt:  maxbusiness1],customer.profileCode,[NSString stringWithFormat: @"01"],[[MJUtility sharedInstance] getMJConfigInfo:@"SalesCode"],[[MJUtility sharedInstance] getMJConfigInfo:@"territory_name"]];
    }
    if(customer.sapphire){
       //NSString *maxbusiness2 = [database stringForQuery:@"SELECT MAX(doc_num) FROM txn_customer_business"];
        int maxbusiness2 = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_business"]+1;
        boolean4 = [database executeUpdate:@"insert into txn_customer_business(doc_num,profile_code,business_code,rep_code,territory_name)VALUES (?,?,?,?,?)",[NSNumber numberWithInt: maxbusiness2],customer.profileCode,[NSString stringWithFormat: @"02"],[[MJUtility sharedInstance] getMJConfigInfo:@"SalesCode"],[[MJUtility sharedInstance] getMJConfigInfo:@"territory_name"]];
    // sapphire = @"02";
    } 
    
    
       if(boolean4 == FALSE)
       {   [database rollback];
           [output setObject: @"N" forKey:@"Status"];
           [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
           
           [database close];
           return output;
    }
    
    
    if(customer.high || customer.medium || customer.low){
       
        
        // find max doc_num 
        
     
        
        
        if(customer.high){
            
            //NSString *maxses1 = [database stringForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"];
             int maxses1 = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"]+1;
            [database executeUpdate:@"INSERT INTO txn_customer_ses(doc_num,profile_code,ses_code) VALUES (?,?,?)",[NSNumber numberWithInt: maxses1],customer.profileCode,@"01"];
        }
        if(customer.medium)
        {
             //NSString *maxses2 = [database stringForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"];
             int maxses2 = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"]+1;
            [database executeUpdate:@"INSERT INTO txn_customer_ses(doc_num,profile_code,ses_code) VALUES (?,?,?)",[NSNumber numberWithInt: maxses2],customer.profileCode,@"02"];
        }
        if(customer.low){
            
            // NSString *maxses3 = [database stringForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"];
             int maxses3 = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_ses"]+1;
            [database executeUpdate:@"INSERT INTO txn_customer_ses(doc_num,profile_code,ses_code) VALUES (?,?,?)",[NSNumber numberWithInt: maxses3],customer.profileCode,@"03"];
        }
        
    }
    
    
    [database commit];
    [is_active release];
    //[database close];
    // return [[MJUtility sharedInstance] newTxn:customer.profileCode type:@"CU" profileCode:customer.profileCode customerCode:customer.customerCode1 appStatus:@"WT"]; 
    
    if([[MJUtility sharedInstance] newTxn:customer.profileCode type:@"CU" profileCode:customer.profileCode customerCode:customer.customerCode1 appStatus:@"WT"])
    {
        [output setObject: @"Y" forKey:@"Status"];
        //[output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        
    }
    [database close];
    return output;
}


-(NSDate*) updateCustomerGPSProfileCode:(NSString*) profileCode withLat: (NSString*) latitute withLong:(NSString*) longtitute 
{
    NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    BOOL boolean1 = [database executeUpdate:@"update txn_customer SET latitude = ? ,longitude = ?, Position_date = CURRENT_TIMESTAMP,  update_date = CURRENT_TIMESTAMP ,update_by = ?  WHERE profile_code = ?", latitute,longtitute,[[MJUtility sharedInstance]getMJConfigInfo:@"SalesCode"] ,profileCode];
    
    if(boolean1)
    {
        date = [database stringForQuery: [NSString stringWithFormat:@"select position_date from txn_customer where profile_code = '%@'",profileCode] ];
    
    }
     [database close];
    [[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"];
    return [[MJUtility sharedInstance] convertStringDateToNSDate:date];
   

}

// update customer child
- (NSMutableDictionary*) updateCustomerChild: (CustomerChild*) child withProfileCode: (NSString*) profileCode
{
  
    // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    child.sex  = [child.sex stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    child.sex = [database stringForQuery:[NSString stringWithFormat: @"SELECT sex_code FROM Mst_sex WHERE TRIM(sex_name) = '%@'",child.sex]];
    
    
    BOOL boolean1 = [database executeUpdate:@"update txn_child SET child_no = ? , child_tname = ?, child_fname = ?, child_lname = ?, sex = ? , bdate = ?,  update_date = CURRENT_TIMESTAMP ,update_by = ?  WHERE profile_code = ? AND child_no = ? ",child.number,child.titleName,child.firstName,child.lastName,child.sex,[[MJUtility sharedInstance] convertNSDateToString:child.birthDate],[[MJUtility sharedInstance]getMJConfigInfo:@"SalesCode"] ,profileCode, child.number];
  
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
  
    
    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
    //    [output setObject: nil forKey:@"ErrorMsg"];
    
    
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
        [database close];
        return output;
    
    
    //return boolean1;
  
    

}
// delete customer child
- (NSMutableDictionary*) deleteCustomerChildByChildNumber: (NSString*) childNumber withProfileCode: (NSString*) profileCode
{
         // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    BOOL boolean1 = [database executeUpdate:@"delete from txn_child  WHERE profile_code = ? AND child_no = ?",profileCode,childNumber];
    
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];

    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
       // [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;
    
    
    
}

// new customer child 
- (NSMutableDictionary*) newCustomerChild: (CustomerChild*) child withProfileCode: (NSString*) profileCode
{   
    

    // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    child.sex  = [child.sex stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    child.sex = [database stringForQuery:[NSString stringWithFormat: @"SELECT sex_code FROM Mst_sex WHERE TRIM(sex_name) = '%@'",child.sex]];
    
    BOOL boolean1 = [database executeUpdate:@"insert into txn_child(profile_code ,child_no,child_tname,child_fname, child_lname ,sex,bdate,record_date,record_by ) VALUES (?,?,?,?,?,?,?,CURRENT_TIMESTAMP,?)",profileCode,child.number,child.titleName,child.firstName,child.lastName,child.sex,[[MJUtility sharedInstance] convertNSDateToString:child.birthDate],[[MJUtility sharedInstance]getMJConfigInfo:@"SalesCode"]];
   
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];

    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
       // [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;
       
    
}

// update customer hobbies
- (NSMutableDictionary*) updateCustomerHobby: (Hobby*) hobby withProfileCode: (NSString*) profileCode
{  
    // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    hobby.name  = [hobby.name stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hobby.name = [database stringForQuery:[NSString stringWithFormat: @"SELECT lifestyle_code FROM Mst_lifestyle WHERE TRIM(lifestyle_name) = '%@'",hobby.name]];
    
    BOOL boolean1 = [database executeUpdate:@"update txn_customer_lifestyle SET lifestyle_code = ? , description = ? WHERE profile_code = ? AND lifestyle_code = ? ",hobby.name, hobby.description ,profileCode, hobby.name];
   
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];

    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
       // [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;
        
    
}
// delete customer hobbies
- (NSMutableDictionary*) deleteCustomerHobbyByHobbyName: (NSString*) hobbyName withProfileCode: (NSString*) profileCode
{   
    // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    hobbyName  = [hobbyName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *hobbyCode = [database stringForQuery: [NSString stringWithFormat:@"select lifestyle_code from mst_lifestyle where lifestyle_name = '%@'",hobbyName] ];
    
    BOOL boolean1 = [database executeUpdate:@"delete from txn_customer_lifestyle  WHERE lifestyle_code = ? AND profile_code = ?",hobbyCode,profileCode];
    
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
       // [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;
       
    
}

// new customer child 
- (NSMutableDictionary*) newCustomerHobby: (Hobby*) hobby withProfileCode: (NSString*) profileCode
{
    // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    hobby.name  = [hobby.name stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hobby.name = [database stringForQuery:[NSString stringWithFormat: @"SELECT lifestyle_code FROM Mst_lifestyle WHERE TRIM(lifestyle_name) = '%@'",hobby.name]];
    
  //  NSString *max = [database stringForQuery:@"SELECT MAX(doc_num) FROM txn_customer_lifestyle"];
    int max = [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_lifestyle"];
    
    BOOL boolean1 = [database executeUpdate:@"insert into txn_customer_lifestyle (doc_num, profile_code ,lifestyle_code,description) VALUES (?,?,?,?)",[NSNumber numberWithInt: max],profileCode,hobby.name, hobby.description];
    
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
       // [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;

    
    
    
}

// update customer workplace // cannot update hospital name
- (NSMutableDictionary*) updateCustomerWorkPlace: (CustomerWorkPlace*) wp withProfileCode: (NSString*) profileCode
{
    // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    wp.department  = [wp.department stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    wp.department = [database stringForQuery:[NSString stringWithFormat: @"SELECT department_code FROM Mst_department WHERE TRIM(department_name) = '%@'",wp.department]];
    
    wp.hospitalName  = [wp.hospitalName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    wp.hospitalName= [database stringForQuery:[NSString stringWithFormat: @"SELECT hospital_code FROM txn_hospital WHERE TRIM(hospital_name) = '%@'",wp.hospitalName]];
    
    
    BOOL boolean1 = [database executeUpdate:@"update txn_customer_addr SET  department_code = ?, building = ?, contact_time = ?  WHERE profile_code = ? AND hospital_code = ? AND address_type = 3" ,wp.department,wp.building ,wp.workTime, profileCode, wp.hospitalName];
    
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
       // [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;

    
    
}

// delete customer Workplace
- (NSMutableDictionary*) deleteCustomerWorkPlaceByHospitalName: (NSString*) hospitalName withProfileCode: (NSString*) profileCode
{
    // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    
    hospitalName  = [hospitalName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hospitalName= [database stringForQuery:[NSString stringWithFormat: @"SELECT hospital_code FROM txn_hospital WHERE TRIM(hospital_name) = '%@'",hospitalName]];
    
    BOOL boolean1 = [database executeUpdate:@"delete from txn_customer_addr  WHERE hospital_code = ? AND profile_code = ? AND address_type = 3 ",hospitalName ,profileCode];
    
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
     //   [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;

    
    
}

// update customer workplace // cannot update hospital name
- (NSMutableDictionary*) newCustomerWorkPlace: (CustomerWorkPlace*) wp withProfileCode: (NSString*) profileCode
{
    // NSString* date;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    wp.department  = [wp.department stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    wp.department = [database stringForQuery:[NSString stringWithFormat: @"SELECT department_code FROM Mst_department WHERE TRIM(department_name) = '%@'",wp.department]];
    
    wp.hospitalName  = [wp.hospitalName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    wp.hospitalName= [database stringForQuery:[NSString stringWithFormat: @"SELECT hospital_code FROM txn_hospital WHERE TRIM(hospital_name) = '%@'",wp.hospitalName]];
    
    int seq = [database intForQuery:[NSString stringWithFormat: @"SELECT MAX(seq) FROM txn_customer_addr WHERE profile_code = '%@'",profileCode]]+1;
    
    BOOL boolean1 = [database executeUpdate:@"insert into txn_customer_addr(profile_code,seq,hospital_code,department_code,building,contact_time,address_type)  VALUES (?,?,?,?,?,?,3)",profileCode,[NSNumber numberWithInt: seq ],wp.hospitalName, wp.department, wp.building,wp.workTime];
    
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
    if (boolean1== FALSE) {
        //[database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
      //  [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;
    

    
    
}

//update customer patient ** recieve NSMutableArray of Customer Patients 
- (NSMutableDictionary*) updateCustomerPatientwith: (NSMutableArray*) cpArray withProfileCode:(NSString*) profileCode{
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
    
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    BOOL boolean2 = TRUE;
    
    [database beginTransaction];
    BOOL boolean1 = [database executeUpdate:@"delete from txn_customer_patient WHERE profile_code = ?",profileCode];
    if(boolean1 == FALSE){
        [database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    
    for (CustomerPatient* cp in cpArray){
        
        if(!([cp.totalBirth isEqualToString:@"0"] && [cp.totalCommercial isEqualToString:@"0"])){
          //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_patient"];
             int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_patient"]+1;
        cp.type  = [cp.type stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        cp.type = [database stringForQuery:[NSString stringWithFormat: @"SELECT patient_type_code FROM Mst_patient_type WHERE TRIM(patient_type_name) = '%@'",cp.type]];
         
        boolean2 = [database executeUpdate:@"insert into txn_customer_patient (doc_num, profile_code ,patient_type_code,total_potential,total_patient_g,total_commercial, total_commercial_g) VALUES (?,?,?,?,?,?,?)",[NSNumber numberWithInt: max ],profileCode,cp.type, cp.totalBirth,cp.totalBirth,cp.totalCommercial,cp.totalCommercial];
        
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
            
    }
            
    }
    [database commit];
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
        //[output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;
}
- (NSMutableDictionary*) updateCustomerStatus: (CustomerStatus*) cp withProfileCode:(NSString*) profileCode{
    
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];

   
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    [database beginTransaction];
    BOOL boolean1 = [database executeUpdate:@"delete from txn_customer_status WHERE profile_code = ?",profileCode];
    
    if(boolean1 == FALSE){
        [database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }  
    
        BOOL boolean2;
    if(cp.Recommender == TRUE){
        //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
         int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
       boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"01"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }

        
    }
    if (cp.RoCommPTC == TRUE){
        //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
        int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"02"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
        
    }
    if (cp.DepartmentHead == TRUE){
        //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
        int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"03"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;        }
        
    }
    if (cp.KOL == TRUE){
     //   int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
       int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1; 
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"04"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
        
    }
    if (cp.EndUseer == TRUE){
       // int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
        int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"05"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
        
    }
    if (cp.DirecAsstDirec == TRUE){
        //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
        int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"06"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
        
    }if (cp.PedOBNurse == TRUE){
        //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
        int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"07"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
        
    }
    if (cp.PedOBDoctor == TRUE){
        //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
        int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"08"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
        
    }
    if (cp.Depo == TRUE){
      //  int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
        int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"09"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
        
    }
    if (cp.PregList == TRUE){
        //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_status"];
        int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_status"]+1;
        boolean2 = [database executeUpdate:@"insert into txn_customer_status (doc_num, profile_code ,status_code) VALUES (?,?,?)",[NSNumber numberWithInt: max ],profileCode,@"10"];
        if(boolean2 == FALSE){
            [database rollback];
            [output setObject: @"N" forKey:@"Status"];
            [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
            
            [database close];
            return output;
        }
        
    }
    
    [database commit];
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
       // [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;
    
    
}


//chweck validity of Patient and productrecommend : Array of CustomerPatient and Array of CustomerProduct

- (BOOL) checkValidityPatient: (NSMutableArray*) cpArray withProductRecommend: (NSMutableArray*) prArray

{   int SumTotalRecQty= 0;
    BOOL valid= FALSE;
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    
    for(CustomerProduct *pr in prArray){
        
        pr.code = [database stringForQuery:[NSString stringWithFormat: @"select patient_type_code  from mst_product_brand WHERE TRIM(prod_brand_name) = '%@'",pr.name]];
    }
    // looping for check validity for each patient_type one by one
    
    for(CustomerPatient *cp in cpArray){
        
        NSString *typeName = [database stringForQuery:@"SELECT patient_type_code FROM mst_patient_type WHERE TRIM (patient_type_name) = ?",cp.type ];
        SumTotalRecQty = 0;
        
        for(CustomerProduct *pr in prArray){
            
            if([pr.code isEqualToString: typeName])
                SumTotalRecQty = SumTotalRecQty + [pr.recQty integerValue] ;
        }
            
        if(SumTotalRecQty <= [cp.totalCommercial integerValue]){
                valid = TRUE;
        }else {
                valid = FALSE;
                break;
        }
    }
    
    return valid;
}

//update customer patient ** recieve NSMutableArray of Customer Products 
- (NSMutableDictionary*) updateCustomerProductwith: (NSMutableArray*) prArray withProfileCode:(NSString*) profileCode{
    
    NSMutableDictionary *output = [NSMutableDictionary dictionary ];
    

    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    [database beginTransaction];
    BOOL boolean2 = TRUE;
    BOOL boolean1 = [database executeUpdate:@"delete from txn_customer_product WHERE profile_code = ?",profileCode];
    if(boolean1 == FALSE){
        [database rollback];
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
        
        [database close];
        return output;
    }
    for (CustomerProduct* pr in prArray){
        
        if(![pr.recQty isEqualToString:@"0"] && boolean2 ){
            
            //NSString *max = [database stringForQuery:@"SELECT MAX(doc_num) FROM txn_customer_patient"];
             //int max =  [[MJUtility sharedInstance] findNewDocnumForTable:@"txn_customer_product"];
            int max = [database intForQuery:@"SELECT MAX(doc_num) FROM txn_customer_product"]+1;
            pr.name  = [pr.name stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            pr.code = [database stringForQuery:[NSString stringWithFormat: @"SELECT prod_brand_code FROM Mst_product_brand WHERE TRIM(prod_brand_name) = '%@'",pr.name]];
            
            boolean2 = [database executeUpdate:@"insert into txn_customer_product (doc_num, profile_code ,prod_brand_code,Recommended_qty) VALUES (?,?,?,?)",[NSNumber numberWithInt: max],profileCode,pr.code, pr.recQty];
            
            if(boolean2 == FALSE){
                [database rollback];
                [output setObject: @"N" forKey:@"Status"];
                [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
                
                [database close];
                return output;
            }
        }  
    }
    
    [database commit];
    if([[MJUtility sharedInstance] checkInTxn:profileCode type: @"CU"])
    {
        [output setObject: @"Y" forKey:@"Status"];
      //  [output setObject: nil forKey:@"ErrorMsg"];
        
        
    }else{
        [output setObject: @"N" forKey:@"Status"];
        [output setObject:[database lastErrorMessage] forKey:@"ErrorMsg"];
    }
    
    [database close];
    return output;
}


#pragma mark- Customer Visit method

-(NSMutableArray*) getDateForRecordCall{
    
    int callbackdays = [[[MJUtility sharedInstance] getMJConfigInfo:@"CallBackTime"] integerValue];
    NSMutableArray* datearray = [NSMutableArray array];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps =
    [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                fromDate:[NSDate date]];
    
    
    [datearray addObject:[calendar dateFromComponents:comps]];
    
    for (int y = 0 ;y < callbackdays ; y++){
        comps.day--;
        [datearray addObject:[calendar dateFromComponents:comps]];
    }
    
    
    
    return datearray;
    
}

// return in form of Array of string
-(NSMutableArray*) getCallObjectiveRecordCall{
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];
    
    
    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT call_objective_name FROM Mst_call_objective"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"call_objective_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return in form of Array of string
-(NSMutableArray*) getCallProductRecordCall{
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];
    
    
    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT prod_brand_name FROM Mst_product_brand"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"prod_brand_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}
// return in form of Array of string
-(NSMutableArray*) getCallResultRecordCall{
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];
    
    
    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT call_result_name FROM Mst_call_result"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"call_result_name"]];
        
        
    } 
    
    [database close];
    
    return array;
}

// return in form of Array of string
-(NSMutableArray*) getCallComplaintRecordCall{
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];
    
    
    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:@"SELECT call_complaint_name FROM Mst_call_complaint"];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"call_complaint_name"]];
        
    } 
    
    [database close];
    
    return array;
}

// return in form of Array of NSString
-(NSMutableArray*) getSupervisorRecordCall{
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    [database open];
    NSMutableArray * array = [NSMutableArray array];
    
    NSString *myself = [[MJUtility sharedInstance] getMJConfigInfo:@"SalesCode"];
    //NSMutableArray * array = [self getAllProductBrandLabel];
    // =      NSString *temp2 = [[NSString alloc] init];                       
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT TRIM(sale_fname) || "  " || TRIM(sale_lname) AS sales  FROM Mst_sale WHERE sale_code <> '%@' ", myself]];
    
    while([results next]) 
        
    {
        [array addObject:[results stringForColumn:@"sales"]];
        
    } 
       
    [database close];
    
    return array;
}




@end