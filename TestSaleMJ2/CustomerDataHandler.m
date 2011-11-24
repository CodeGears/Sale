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

@implementation CustomerDataHandler

- (id) init
{
    if (self = [super init])
    {
         }
    return self;
}

-(void)dealloc{
    
    [super dealloc];
}





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
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT photo,ocup_code, cust_tname, cust_fname, cust_lname, profile_code, customer_code1,customer_code2,customer_code3,email,mobile,sex, bdate, idno,latitude,longitude, Position_date, edu_level_code, edu_major_code, edu_place_code, marry_status_code, spouse_tname, spouse_fname, spouse_lname, spouse_bdate,hhi_code from txn_customer WHERE is_active = 'Y' AND profile_code = '%@' ", profileCode]];
    

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
        customer.telephone = [results stringForColumn:@"mobile"];
        customer.sex = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_sex" resultColumn:@"sex_name" codeColumn: @"sex_code" code:[results stringForColumn:@"sex"]];
        customer.birthDay = [[MJUtility sharedInstance]convertStringDateToNSDate:[results stringForColumn: @"bdate"]];
        customer.idNumber = [results stringForColumn:@"idno"];
        customer.latitude = [results stringForColumn:@"latitude"];
        customer.longtitude = [results stringForColumn: @"longitude"];
        customer.gpsupdateDate = [[MJUtility sharedInstance]convertStringDateToNSDate:[results stringForColumn: @"Position_date"]];
       customer.educationLevel = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_edu_level" resultColumn:@"edu_level_name" codeColumn: @"edu_level_code" code:[results stringForColumn:@"edu_level_code"]];
        customer.educationMajor = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_edu_major" resultColumn:@"edu_major_name" codeColumn: @"edu_major_code" code:[results stringForColumn:@"edu_major_code"]];
        customer.educationLevel = [[MJUtility sharedInstance] getPicklistValueFromTable: @"Mst_edu_place" resultColumn:@"edu_place_name" codeColumn: @"edu_place_code" code:[results stringForColumn:@"edu_place_code"]];
        
        customer.maritialStat = [[MJUtility sharedInstance] getPicklistValueFromTable: @"mst_marry_status" resultColumn:@"marry_status_name" codeColumn: @"marry_status_code" code:[results stringForColumn:@"marry_status_code"]];
        customer.spouseTitleName = [results stringForColumn:@"spouse_tname"];
        customer.spouseFirstName = [results stringForColumn:@"spouse_fname"];
         customer.spouseLastName = [results stringForColumn:@"spouse_lname"];
        customer.spousebirthdate = [[MJUtility sharedInstance] convertStringDateToNSDate:[results stringForColumn:@"spouse_bdate"]];
       customer.hhIncome = [[MJUtility sharedInstance] getPicklistValueFromTable: @"mst_house_hold_income" resultColumn:@"hhi_name" codeColumn: @"hhi_code" code:[results stringForColumn:@"hhi_code"]];
        
        
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
        customer.homeZip = [results stringForColumn:@"zip "];
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
        customer.clinicZip = [results stringForColumn:@"zip "];
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
        NSString* temp2 = [results stringForColumn:@"business_code"];
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
    
    return customer;
}

- (NSMutableArray*) getAllCustomerChildren: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 

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
    
    NSMutableArray *hobbyArray = [[NSMutableArray alloc]init ];
    
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT b.lifestyle_name ,a.description from  txn_customer_lifestyle a, Mst_lifestyle b  WHERE b.lifestyle_code = a.lifestyle_code AND a.profile_code = '108024' ", profileCode]];
    
    while([results next]) 
        
    {
        Hobby *hobby = [[Hobby alloc] init];
        //cusList            //hospitalName = [results stringForColumn: @"hospital_name"];
        hobby.description = [results stringForColumn: @"lifestyle_name"];
      
        hobby.name = [results stringForColumn: @"description"];

        
        [hobbyArray addObject: hobby];
        [hobby release];
    }  
    [database close];
    return hobbyArray;
    
    
}

// get all customer member return in form of Array of CustomerMember

- (NSMutableArray*) getAllMembers: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
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

- (NSMutableArray*) getAllPatientTypeLabel: (NSString*) profileCode{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
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
    
    NSMutableArray * array = [[NSMutableArray alloc]init ];
    
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT  patient_type_name , total_commercial , total_potential from mst_patient_type  LEFT OUTER JOIN txn_customer_patient ON txn_customer_patient.patient_type_code = mst_patient_type.patient_type_code  where txn_customer_patient.profile_code = '%@' ORDER BY  mst_patient_type.patient_type_code" , profileCode]];
    
    while([results next]) 
        
    {
        CustomerPatient *cp = [[CustomerPatient alloc] init];
        
        cp.type = [results stringForColumn: @"patient_type_name"];
        cp.totalBirth = [results stringForColumn: @"total_potential"];
        cp.totalCommercial = [results stringForColumn: @"total_commercial"];
        

        [array addObject: cp];
        [cp release];
    } 
    [database close];
    return array;
    
    
}
/*
// get real record to update the list, return in form of Product Recommendation

- (*) getAllProductRecommendation: (NSString*) profileCode{
   
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    NSMutableArray * array = [[NSMutableArray alloc]init ];
    
    
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat: @"SELECT  patient_type_name , total_commercial , total_potential from mst_patient_type  LEFT OUTER JOIN txn_customer_patient ON txn_customer_patient.patient_type_code = mst_patient_type.patient_type_code  where txn_customer_patient.profile_code = '%@' ORDER BY  mst_patient_type.patient_type_code" , profileCode]];
    
    while([results next]) 
        
    {
        CustomerPatient *cp = [[CustomerPatient alloc] init];
        
        cp.type = [results stringForColumn: @"patient_type_name"];
        cp.totalBirth = [results stringForColumn: @"total_potential"];
        cp.totalCommercial = [results stringForColumn: @"total_commercial"];
        
        
        [array addObject: cp];
        [cp release];
    } 
    [database close];
    return array;

    
}
*/






@end
