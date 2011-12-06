//
//  CustomerDataModel.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomerDataManager.h"
#import "CustomerDataHandler.h"
#import "MJUtility.h"
#import "CustomerList.h"
#import "Customer.h"
#import "CustomerChild.h"
#import "Hobby.h"
#import "CustomerWorkPlace.h"
#import "CustomerPatient.h"
#import "CustomerProduct.h"

@implementation ContactProfile

@synthesize profileCode,name,group,isActive;


@end




@implementation CustomerDataManager
@synthesize nameKeys,nameList, customerType;
@synthesize customerName, customerWorkName;
@synthesize systemInfo,personalInfo,locationInfo,educationInfo, familyInfo,childInfo,hobbyInfo,memberInfo,homeInfo,clinicInfo,workplaceDetail,bussinessDetail,customerPatient,productRecommend,status,ses;

static CustomerDataManager* _sharedInstance = nil;

#pragma mark- Singleton method
+ (id) sharedInstance{
    @synchronized(self){
    if (_sharedInstance == nil) {
        _sharedInstance = [[[self class] alloc] init];
        
        _sharedInstance.nameKeys = nil;
        _sharedInstance.nameList = nil;
    }
    }
    return _sharedInstance;
}

+ (id) allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (_sharedInstance == nil) {
            _sharedInstance = [super allocWithZone:zone];
            return _sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone{
    return self;
}

- (id) retain{
    return self;
}

- (NSUInteger)retainCount{
    return NSUIntegerMax;
}

-(void)dealloc{
    [nameKeys release];
    [nameList release];
    
    [customerType release];
    
    [customerName release];
    [customerWorkName release];
    
    [systemInfo release];
    [personalInfo release];
    [locationInfo release];
    [educationInfo release];
    [childInfo release];
    [hobbyInfo release];
    [memberInfo release];
    [homeInfo release];
    [clinicInfo release];
    [workplaceDetail release];
    [bussinessDetail release];
    [customerPatient release];
    [productRecommend release];
    [status release];
    [ses release];
    //[customer release];
    
    [_sharedInstance release];
    [super dealloc];
}

- (id)autorelease{
    return self;
}

#pragma mark- Name Dictionary handles

- (NSArray*) GetCustomerNameKeys{
    
    if (_sharedInstance.nameKeys == nil) {
        
        _sharedInstance.nameKeys = [[NSArray alloc] initWithObjects:@"ก",@"ข",@"ค",@"ง",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    }
    
    //Need one array of section header list
    return _sharedInstance.nameKeys;
}

- (NSArray*) GetCustomerNameList:(NSString*)type{
    
    if (_sharedInstance.nameList == nil) {
        
        //Create dynamic array for the example
        NSMutableArray* alist = [[NSMutableArray alloc] initWithCapacity:99];
        
        //Example Create Database+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        
        NSString* docsDir;
        NSArray* dirPaths;
        
        //Get document directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        
        //Build path
        databasePath_contactDB = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"contact.db"]];
        
        //Use filemanager to check file at path
        NSFileManager *filemgr = [NSFileManager defaultManager];
        if ([filemgr fileExistsAtPath:databasePath_contactDB] == NO) {
            const char* dbpath = [databasePath_contactDB UTF8String];
            if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
                char*errmsg;
                const char*sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, GROUP TEXT, ACTIVE BOOL)";
                if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errmsg) != SQLITE_OK) {
                    NSLog(@"Failed to create table");
                }
                
                //Searching Name begin with 'A'
                sqlite3_stmt* statment;
                NSString* querySQL = [NSString stringWithFormat:@"SELECT name FROM contacts WHERE name=\"a\""];
                
                const char* query_stmt = [querySQL UTF8String];
                //Searching
                if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statment, NULL) == SQLITE_OK) {
                    
                    if (sqlite3_step(statment) == SQLITE_ROW) {
                        //Get Data from each column
                        NSString* textCode = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statment, 0)];
                        NSString* textName = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statment, 1)];
                        NSString* textGroup = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statment, 2)];
                        NSInteger active = sqlite3_column_int(statment, 3);
                        
                        //insert to list
                        ContactProfile* tempProfile = [[ContactProfile alloc] init];
                        tempProfile.profileCode = textCode;
                        tempProfile.name = textName;
                        tempProfile.group = textGroup;
                        tempProfile.isActive = active;
                        
                        
                        [alist addObject:tempProfile];
                        //it get only one time
                        
                        
                        NSLog(@"Search Found");
                        
                    }
                    else{
                        NSLog(@"Not Found");
                       
                    }
                    sqlite3_finalize(statment); 
                }
                
                sqlite3_close(contactDB);
            }
            else{
                NSLog(@"Failed to open/create database");
            }
        }
        [filemgr release];
        
        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //Test 
       // CustomerDataHandler *custhand = [[CustomerDataHandler alloc]init];
        NSArray *customerArray = [[CustomerDataHandler sharedInstance] getCustometListByType:@"All Profile"];
        if ([customerArray count] >0){
            CustomerList *temp1 = [customerArray objectAtIndex: 0 ]; 
            
            //Temp Code
            
            ContactProfile* tempProfile = [[ContactProfile alloc] init];
            tempProfile.profileCode = temp1.profileCode;
            tempProfile.name = temp1.name;
            tempProfile.group = temp1.grade;
            tempProfile.isActive = temp1.isActive;
            
         /*   
            // Testing cusdetail
         Customer *custnew = [[CustomerDataHandler sharedInstance] getCustomerDetailbyProfileCode:@"101345"];
            
        
            // test Add new customer
        
          BOOL boolean1 = [[CustomerDataHandler sharedInstance] newCustomerDetail:custnew];
            
            if(boolean1)
                NSLog(@"new customer OK");
            else  NSLog(@"new customer NO OK");
          */  
            // test update customer detail
            
            Customer *custnew2 = [[CustomerDataHandler sharedInstance] getCustomerDetailbyProfileCode:@"122314"];
            custnew2.profileCode = @"010950";
           /*
            BOOL boolean2 = [[CustomerDataHandler sharedInstance] updateCustomerDetail:custnew2];
            
            if(boolean2)
                NSLog(@"update customer OK");
            else  NSLog(@"update customer NO OK");
*/
           /* 
            // test Customer GPS update 
            custnew2.longtitude = @"1213123";
            custnew2.latitude = @"123892173";
           NSDate *moddate = [[CustomerDataHandler sharedInstance] updateCustomerGPS:custnew2.profileCode withLat: custnew2.latitude withLong:custnew2.longtitude];
            
            NSLog([NSString stringWithFormat: @"update customerGPS OK moddate = %@ ",[[MJUtility sharedInstance]convertNSDateToString: moddate]]);
           // else  NSLog(@"update customerGPS NO OK");
            */
            
            
            // testing Cuschild
            NSMutableArray *a = [[CustomerDataHandler sharedInstance] getAllCustomerChildren:@"101802"];
            
            
            for(CustomerChild *c in a ){
                NSLog(@"%@", c.number);
                NSLog(@"%@", c.titleName);
                 NSLog(@"%@", c.firstName);
                 NSLog(@"%@", c.lastName);
                 NSLog(@"%@", c.sex);
                 NSLog(@"%@", [c.birthDate description]);
                
                /*
                // test update Customer Child 
                c.titleName = @"abc";
                BOOL boolean1 = [[CustomerDataHandler sharedInstance] updateCustomerChild:c withProfileCode:@"101802"];
                
                if(boolean1)
                    NSLog(@"new child OK");
                else  NSLog(@"new child NO OK");
                */
                /*
                //test new customer childT
                BOOL boolean2 = [[CustomerDataHandler sharedInstance] deleteCustomerChildByChildNumber:c.number withProfileCode:@"010950"];
                
                if(boolean2)
                    NSLog(@"delete child OK");
                else  NSLog(@"delete child NO OK");
            

                
                
                c.titleName = @"abc";
                BOOL boolean1 = [[CustomerDataHandler sharedInstance] newCustomerChild:c withProfileCode:@"010950"];
                
                if(boolean1)
                    NSLog(@"new child OK");
                else  NSLog(@"new child NO OK");
                 */
            }
            
           
            
            
            // testing hobby
            NSMutableArray *b = [[CustomerDataHandler sharedInstance] getAllHobbies:@"101802"];
            
            
            for(Hobby *d in b ){
                NSLog(@"%@", d.name);
                NSLog(@"%@", d.description);
                
                
                
                
                     // test new Customer hobby
                    // c.titleName = @"abc";
              /*       BOOL boolean1 = [[CustomerDataHandler sharedInstance] newCustomerHobby:d withProfileCode: @"010950"];
                     
                     if(boolean1)
                     NSLog(@"new hobby OK");
                     else  NSLog(@"new hobby NO OK");
                    
                    
                    
                 */   
                    
                 /*   //testupdate
                    
                    d.description = @"abcdefg";
                BOOL boolean3 = [[CustomerDataHandler sharedInstance] updateCustomerHobby:d withProfileCode: @"010950"];
                                     if(boolean3)
                        NSLog(@"update hopb OK");
                    else  NSLog(@"update hob NO OK");
                */
                //test delete customer childT
                /*
                BOOL boolean2 = [[CustomerDataHandler sharedInstance] deleteCustomerHobbyByHobbyName: d.name withProfileCode: @"010950"];
                
                if(boolean2)
                    NSLog(@"delete child OK");
                else  NSLog(@"delete child NO OK");
                */
                            }
            // testing Cuschild
            NSMutableArray *e = [[CustomerDataHandler sharedInstance]getAllWorkPlaces:@"166705"];
            
            
            for(CustomerWorkPlace *f in e ){
                NSLog(@"%@", f.hospitalName);
                NSLog(@"%@", f.workTime);
                NSLog(@"%@", f.department);
                NSLog(@"%@", f.building);
              //  NSLog(@"%@", c.sex);
                //NSLog(@"%@", [c.birthDate description]);
                /*
                //test new workplace
                //f.building = @"abakldf";
                BOOL boolean2 = [[CustomerDataHandler sharedInstance] deleteCustomerWorkPlaceByHospitalName: f.hospitalName withProfileCode: @"010950"];
                
                if(boolean2)
                    NSLog(@"update workplace  OK");
                else  NSLog(@" new work plae OK");
                
                */
            }
            
            NSMutableArray *g = [[CustomerDataHandler sharedInstance] getAllPatientType:@"101802"];
            
            
            for(CustomerPatient *q in g ){
                NSLog(@"%@ %@ %@", q.type,q.totalBirth ,q.totalCommercial );
                //q.totalBirth =@"6";
                //q.totalCommercial = @"3";
               // NSLog(@"%@", q.building);
                //  NSLog(@"%@", c.sex);
                //NSLog(@"%@", [c.birthDate description]);
            }
            /*
            BOOL boolean2 = [[CustomerDataHandler sharedInstance] updateCustomerPatientwith:g with: @"010950"];           
            if(boolean2)
                NSLog(@"update patient  OK");
            else  NSLog(@" new patient OK");
                            
             g = [[CustomerDataHandler sharedInstance] getAllPatientType:@"101802"];
            
            for(CustomerPatient *q in g ){
                NSLog(@"result %@ %@ %@", q.type,q.totalBirth ,q.totalCommercial );
                
                // NSLog(@"%@", q.building);
                //  NSLog(@"%@", c.sex);
                //NSLog(@"%@", [c.birthDate description]);
            }
            */
            // test Customer Status
            CustomerStatus *r = [[CustomerDataHandler sharedInstance] getAllStatus:@"101802"];
            if(r.Recommender)
                NSLog(@" recommender");
            if(r.KOL)
                NSLog(@" kol 04");
            if(r.PedOBDoctor)
                NSLog(@" oedobdocter");
            
                       
            if([[[[CustomerDataHandler sharedInstance] updateCustomerStatus:r withProfileCode:@"010950"] objectForKey:@"Status"] isEqualToString:@"Y"])
                NSLog(@"update status OK");
            else  NSLog(@" update no status OK");   
        
            // get call product brand
            NSMutableArray *t = [[CustomerDataHandler sharedInstance] getAllProductBrand:@"101802"];
            
            
            
            
            for(CustomerProduct *u in t ){
                NSLog(@"%@", u.name );
                NSLog(@"%@", u.code);
                NSLog(@"%@", u.recQty);
                // NSLog(@"%@", q.building);
                //  NSLog(@"%@", c.sex);
                //NSLog(@"%@", [c.birthDate description]);
                
            }
            /*
            BOOL boolean2 = [[CustomerDataHandler sharedInstance] updateCustomerProductwith:t  with:@"010950"];           
            if(boolean2)
                NSLog(@"update product OK");
            else  NSLog(@" update no prouduct OK");     
            */
            
            //check validity patient
            BOOL boolean2 = [[CustomerDataHandler sharedInstance] checkValidityPatient:g withProductRecommend:t];           
            if(boolean2)
                NSLog(@"update product OK");
            else  NSLog(@" update no prouduct OK");     
            
           // [custhand release];
            //testing
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
/*
        
        //Temp Code
        
        ContactProfile* tempProfile = [[ContactProfile alloc] init];
        tempProfile.profileCode = @"001";
        tempProfile.name = @"Test Name";
        tempProfile.group = @"Group1";
        tempProfile.isActive = 1;
 */
        
        //NSArray* alist = [[NSArray alloc] initWithObjects: @"aa", @"aaa",nil];
        NSArray* blist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* clist = [[NSArray alloc] initWithObjects: tempProfile, tempProfile,nil];
        NSArray* dlist = [[NSArray alloc] initWithObjects: tempProfile, tempProfile,nil];
        NSArray* elist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* flist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* glist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* hlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* ilist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* jlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* klist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* llist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* mlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* nlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* olist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* plist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* qlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* rlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* slist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* tlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* ulist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* vlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* wlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* xlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* ylist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        NSArray* zlist = [[NSArray alloc] initWithObjects: tempProfile,nil];
        
        //Create Dictionary data
        _sharedInstance.nameList = [[NSArray alloc] initWithObjects:alist,blist,clist,dlist,elist,flist,glist,hlist,ilist,jlist,klist,llist,mlist,nlist,olist,plist,qlist,rlist,slist,tlist,ulist,vlist,wlist,xlist,ylist,zlist,nil];
        
        [tempProfile release];
        
        [zlist release];
        [ylist release];
        [xlist release];
        [wlist release];
        [vlist release];
        [ulist release];
        [tlist release];
        [slist release];
        [rlist release];
        [qlist release];
        [plist release];
        [olist release];
        [nlist release];
        [mlist release];
        [llist release];
        [klist release];
        [jlist release];
        [ilist release];
        [hlist release];
        [glist release];
        [flist release];
        [elist release];
        [dlist release];
        [clist release];
        [blist release];
        [alist release];
            
        
        }
    }
    
    
    // Need Array of objects for each section table
    return _sharedInstance.nameList;
}

- (NSArray*) GetCustomerType{
    
    // stk add
    //CustomerDataHandler *customerHandler = [[CustomerDataHandler alloc] init] ;
    
    if (_sharedInstance.customerType == nil) {
        _sharedInstance.customerType = [[CustomerDataHandler sharedInstance] getAllCustomerType];
    }
    // stk add
    //[customerHandler release];
    return _sharedInstance.customerType;}


- (NSString*) GetPictureProfilePath:(NSString*)profileCode{
    return @"";
}

- (NSString*) GetCustomerDetailName:(NSString*)profileCode{
    
    _sharedInstance.customerName = @"ttttt   tttttt";
    return _sharedInstance.customerName;
}

- (NSString*) GetCustomerWorkName:(NSString*)profileCode{
    _sharedInstance.customerWorkName = @"work name";
    return _sharedInstance.customerWorkName;
}

- (NSArray*) GetCustomerDetailSystemInfo:(NSString*)profileCode{
    if (_sharedInstance.systemInfo == nil) {
        NSString* profileCode = [NSString stringWithFormat:@"1234"];
        NSString* profile1 = [NSString stringWithFormat:@"12345"];
        NSString* profile2 = [NSString stringWithFormat:@"12345"];
        NSString* profile3 = [NSString stringWithFormat:@"12345"];
        
        _sharedInstance.systemInfo = [[NSArray alloc] initWithObjects:profileCode,profile1,profile2,profile3, nil];
    }
    return _sharedInstance.systemInfo;
}

- (NSArray*) GetCustomerDetailPersonalInfo:(NSString*)profileCode{
    if (_sharedInstance.personalInfo == nil) {
        NSString* email = [NSString stringWithFormat:@"suthikiet#crm-c.com"];
        NSString* tel = [NSString stringWithFormat:@"0899999999"];
        NSString* sex = [NSString stringWithFormat:@"Male"];
        NSString* brithday = [NSString stringWithFormat:@"12/11/2011"];
        NSString* number = [NSString stringWithFormat:@"1234567890123"];
        
        _sharedInstance.personalInfo = [[NSArray alloc] initWithObjects:email,tel,sex,brithday,number, nil];
    }
    return _sharedInstance.personalInfo;
}

- (NSArray*) GetCustomerDetailLocation:(NSString*)profileCode{
    if (_sharedInstance.locationInfo == nil) {
        NSString* latitude = [NSString stringWithFormat:@"1234"];
        NSString* longtitude = [NSString stringWithFormat:@"12345"];
        NSString* UpdateDate = [NSString stringWithFormat:@"11/11/2011"];
        
        _sharedInstance.locationInfo = [[NSArray alloc] initWithObjects:latitude,longtitude,UpdateDate, nil];
    }
    return _sharedInstance.locationInfo;
}

- (NSArray*) GetCustomerDetailEducationInfo:(NSString*)profileCode{
    if (_sharedInstance.educationInfo == nil) {
        NSString* educationLevel = [NSString stringWithFormat:@"P.D."];
        NSString* educationMajor = [NSString stringWithFormat:@"Doctor"];
        NSString* educationPlace = [NSString stringWithFormat:@"Jula"];
        
        _sharedInstance.educationInfo = [[NSArray alloc] initWithObjects:educationLevel,educationMajor,educationPlace, nil];
    }
    return _sharedInstance.educationInfo;
}

- (NSArray*) GetCustomerDetailFamilyInfo:(NSString*)profileCode{
    if (_sharedInstance.familyInfo == nil) {
        NSString* martialStatus = [NSString stringWithFormat:@"Married"];
        NSString* spourse = [NSString stringWithFormat:@"Miss Sunchai"];
        NSString* spourseBirthDate = [NSString stringWithFormat:@"12/11/2011"];
        NSString* childCount = [NSString stringWithFormat:@"1"];
        NSString* netIncome = [NSString stringWithFormat:@"50000-99999 Bath"];
        
        _sharedInstance.familyInfo = [[NSArray alloc] initWithObjects:martialStatus,spourse,spourseBirthDate,childCount,netIncome, nil];
    }
    return _sharedInstance.familyInfo;
}


- (NSInteger) GetCustomerDetailChildCount:(NSString*)profileCode{
    return 3;
}

- (NSArray*) GetCustomerDetailChildInfo:(NSString*)profileCode{
    if (_sharedInstance.childInfo == nil) {
        
        NSInteger childCount = [_sharedInstance GetCustomerDetailChildCount:@""];
        
        _sharedInstance.childInfo = [[NSMutableArray alloc] initWithCapacity: 99];
        
        for (int i=0; i<childCount; i++) {
            NSString* childName = [NSString stringWithFormat:@"chaiya"];
            NSString* childData = [NSString stringWithFormat:@"Age 20 Birthdate 12/10/2003"];
            NSArray* child = [[NSArray alloc] initWithObjects:childName,childData, nil];
            
            [_sharedInstance.childInfo addObject:child];
        }
    }
    return _sharedInstance.childInfo;
}

- (NSInteger) GetCustomerDetailHobbyInfoCount:(NSString*)profileCode{
    return 2;
}

- (NSArray*) GetCustomerDetailHobbyInfo:(NSString*)profileCode{
    if (_sharedInstance.hobbyInfo == nil) {
        
        NSInteger hobbyCount = [_sharedInstance GetCustomerDetailHobbyInfoCount:@""];
        
        _sharedInstance.hobbyInfo = [[NSMutableArray alloc] initWithCapacity: 99];
        
        for (int i=0; i<hobbyCount; i++) {
            NSString* hobbyName = [NSString stringWithFormat:@"Dance"];
            NSString* hobbyData = [NSString stringWithFormat:@"Expanse Place"];
            NSArray* hobby = [[NSArray alloc] initWithObjects:hobbyName,hobbyData, nil];
            
            [_sharedInstance.hobbyInfo addObject:hobby];
        }
    }
    return _sharedInstance.hobbyInfo;
}

- (NSInteger) GetCustomerDetailMemberDetailCount:(NSString*)profileCode{
    return 2;
}

- (NSArray*) GetCustomerDetailMemberDetail:(NSString*)profileCode{
    if (_sharedInstance.memberInfo == nil) {
        
        NSInteger memberCount = [_sharedInstance GetCustomerDetailMemberDetailCount:@""];
        
        _sharedInstance.memberInfo = [[NSMutableArray alloc] initWithCapacity: 99];
        
        for (int i=0; i<memberCount; i++) {
            NSString* memberID = [NSString stringWithFormat:@"123456"];
            NSString* membername = [NSString stringWithFormat:@"Sutgukiet boo"];
            NSString* beginDate = [NSString stringWithFormat:@"12/31/2001"];
            NSString* expireDate = [NSString stringWithFormat:@"12/31/2044"];
            NSString* memberStatus = [NSString stringWithFormat:@"Y"];
            NSArray* member = [[NSArray alloc] initWithObjects:memberID,membername,beginDate,expireDate,memberStatus, nil];
            
            [_sharedInstance.memberInfo addObject:member];
        }
    }
    return _sharedInstance.memberInfo;
}

- (NSArray*) GetCustomerDetailHomeInfo:(NSString*)profileCode{
    if (_sharedInstance.homeInfo == nil) {
        NSString* address1 = [NSString stringWithFormat:@"Praramkao hospital"];
        NSString* address2 = [NSString stringWithFormat:@"99 parramkao"];
        NSString* subdistrict = [NSString stringWithFormat:@"-"];
        NSString* district = [NSString stringWithFormat:@"huikwang"];
        NSString* Province = [NSString stringWithFormat:@"BKK"];
        NSString* zip = [NSString stringWithFormat:@"10320"];
         NSString* phone = [NSString stringWithFormat:@"084985433"];
         NSString* ext = [NSString stringWithFormat:@""];
         NSString* fax = [NSString stringWithFormat:@"083999999"];
         NSString* conveniencetime = [NSString stringWithFormat:@"afternoon"];
        _sharedInstance.homeInfo = [[NSArray alloc] initWithObjects:address1,address2,subdistrict,district,Province,zip,phone,ext,fax,conveniencetime, nil];
    }
    return _sharedInstance.homeInfo;
}

- (NSArray*) GetCustomerDetailClinicInfo:(NSString*)profileCode{
    if (_sharedInstance.clinicInfo == nil) {
        NSString* address1 = [NSString stringWithFormat:@"Praramkao hospital"];
        NSString* address2 = [NSString stringWithFormat:@"99 parramkao"];
        NSString* subdistrict = [NSString stringWithFormat:@"-"];
        NSString* district = [NSString stringWithFormat:@"huikwang"];
        NSString* Province = [NSString stringWithFormat:@"BKK"];
        NSString* zip = [NSString stringWithFormat:@"10320"];
        NSString* phone = [NSString stringWithFormat:@"084985433"];
        NSString* ext = [NSString stringWithFormat:@""];
        NSString* fax = [NSString stringWithFormat:@"083999999"];
        NSString* conveniencetime = [NSString stringWithFormat:@"afternoon"];
        _sharedInstance.clinicInfo = [[NSArray alloc] initWithObjects:address1,address2,subdistrict,district,Province,zip,phone,ext,fax,conveniencetime, nil];
    }
    return _sharedInstance.clinicInfo;
}

- (NSInteger) GetCustomerDetailWorkplaceDetailCount:(NSString*)profileCode{
    return 2;
}

- (NSArray*) GetCustomerDetailWorkplaceDetail:(NSString*)profileCode{
    if (_sharedInstance.workplaceDetail == nil) {
        
        NSInteger workplaceCount = [_sharedInstance GetCustomerDetailWorkplaceDetailCount:@""];
        
        _sharedInstance.workplaceDetail = [[NSMutableArray alloc] initWithCapacity: 99];
        
        for (int i=0; i<workplaceCount; i++) {
            NSString* workplaceName = [NSString stringWithFormat:@"Saint Luy Hospital"];
            NSString* workplaceData = [NSString stringWithFormat:@"Description"];
            NSArray* workplace = [[NSArray alloc] initWithObjects:workplaceName, workplaceData, nil];
            
            [_sharedInstance.workplaceDetail addObject:workplace];
        }
    }
    return _sharedInstance.workplaceDetail;
}

- (NSArray*) GetCustomerDetailBussinessDetail:(NSString*)profileCode{
    if (_sharedInstance.bussinessDetail == nil) {
        NSString* emarald = [NSString stringWithFormat:@"yes"];
        NSString* sapphire = [NSString stringWithFormat:@"yes"];
        
        _sharedInstance.bussinessDetail = [[NSArray alloc] initWithObjects:emarald,sapphire, nil];
    }
    
    return _sharedInstance.bussinessDetail;
}

- (NSArray*) GetCustomerDetailCustomerPatient:(NSString*)profileCode{
    if (_sharedInstance.customerPatient == nil) {
        NSString* stage0 = [NSString stringWithFormat:@"Stage 0"];
        NSString* stage0_1 = [NSString stringWithFormat:@"100"];
        NSString* stage0_2 = [NSString stringWithFormat:@"20"];
        NSArray* stage0_Array = [[NSArray alloc] initWithObjects:stage0, stage0_1, stage0_2,nil];
        
        NSString* stage1 = [NSString stringWithFormat:@"Stage 1 Premium"];
        NSString* stage1_1 = [NSString stringWithFormat:@"60"];
        NSString* stage1_2 = [NSString stringWithFormat:@"20"];
        NSArray* stage1_Array = [[NSArray alloc] initWithObjects:stage1, stage1_1, stage1_2,nil];

        NSString* stage2E = [NSString stringWithFormat:@"Stage 2 Economy"];
        NSString* stage2E_1 = [NSString stringWithFormat:@"0"];
        NSString* stage2E_2 = [NSString stringWithFormat:@"0"];
        NSArray* stage2E_Array = [[NSArray alloc] initWithObjects:stage2E, stage2E_1, stage2E_2,nil];

        NSString* special = [NSString stringWithFormat:@"Special Group"];
        NSString* special_1 = [NSString stringWithFormat:@"0"];
        NSString* special_2 = [NSString stringWithFormat:@"0"];
        NSArray* special_Array = [[NSArray alloc] initWithObjects:special, special_1, special_2,nil];

        NSString* stage2P = [NSString stringWithFormat:@"Stage 2 Premium"];
        NSString* stage2P_1 = [NSString stringWithFormat:@"300"];
        NSString* stage2P_2 = [NSString stringWithFormat:@"200"];
        NSArray* stage2P_Array = [[NSArray alloc] initWithObjects:stage2P, stage2P_1, stage2P_2,nil];

        NSString* stage2E2 = [NSString stringWithFormat:@"Stage 2 Economy"];
        NSString* stage2E2_1 = [NSString stringWithFormat:@"40"];
        NSString* stage2E2_2 = [NSString stringWithFormat:@"10"];
        NSArray* stage2E2_Array = [[NSArray alloc] initWithObjects:stage2E2, stage2E2_1, stage2E2_2,nil];

        _sharedInstance.customerPatient = [[NSArray alloc] initWithObjects:stage0_Array,stage1_Array,stage2E_Array,special_Array,stage2P_Array,stage2E2_Array, nil];
    }
    return _sharedInstance.customerPatient;
}


- (NSArray*) GetCustomerDetailProductRecommend:(NSString*)profileCode{
    if (_sharedInstance.productRecommend == nil) {
        NSString* snow = [NSString stringWithFormat:@"Snow"];
        NSString* snow_1 = [NSString stringWithFormat:@"1"];
        NSArray* snow_Array = [[NSArray alloc] initWithObjects:snow, snow_1,nil];
        
        NSString* snow2 = [NSString stringWithFormat:@"Something"];
        NSString* snow2_1 = [NSString stringWithFormat:@"1"];
        NSArray* snow2_Array = [[NSArray alloc] initWithObjects:snow2, snow2_1,nil];
        
        _sharedInstance.productRecommend = [[NSArray alloc] initWithObjects:snow_Array,snow2_Array, nil];
    }
    return _sharedInstance.productRecommend;
}

- (NSArray*) GetCustomerDetailStatus:(NSString*)profileCode{
    if (_sharedInstance.status == nil) {
        
        NSString* recommender = [NSString stringWithFormat:@"no"];
        NSString* roComm_ptc = [NSString stringWithFormat:@"no"];
        NSString* department_head = [NSString stringWithFormat:@"yes"];
        NSString* kol = [NSString stringWithFormat:@"no"];
        NSString* end_users = [NSString stringWithFormat:@"yes"];
        NSString* directir_assistDi = [NSString stringWithFormat:@"no"];
        NSString* ped_obNurse = [NSString stringWithFormat:@"yes"];
        NSString* ped_obDoctor = [NSString stringWithFormat:@"no"];
        NSString* depo = [NSString stringWithFormat:@"no"];
        NSString* pregList = [NSString stringWithFormat:@"no"];
        NSString* editDate = [NSString stringWithFormat:@"12/30/2011"];
        
        _sharedInstance.status = [[NSArray alloc] initWithObjects:recommender,roComm_ptc,department_head,kol,end_users,directir_assistDi,ped_obNurse,ped_obDoctor,depo,pregList,editDate, nil];
    }
    
    return _sharedInstance.status;
}

- (NSArray*) GetCustomerDetailSES:(NSString*)profileCode{
    if (_sharedInstance.ses == nil) {
        NSString* high = [NSString stringWithFormat:@"yes"];
        NSString* medium = [NSString stringWithFormat:@"yes"];
        
        _sharedInstance.ses = [[NSArray alloc] initWithObjects:high,medium, nil];
    }
    
    return _sharedInstance.ses;
}



//Sub

- (NSArray*) GetCustomerDetailEditChildInfo:(NSString*)profileCode WithChild:(NSString *)childID{
   
        NSString* childnumber = [NSString stringWithFormat:@"1"];
        NSString* childname = [NSString stringWithFormat:@"xmen"];
        NSString* sex = [NSString stringWithFormat:@"male"];
        NSString* birthdate = [NSString stringWithFormat:@"02/02/2000"];
        
        NSArray* aa = [[NSArray alloc] initWithObjects:childnumber,childname,sex,birthdate, nil];
    
    
    return aa;
}

- (bool) SaveEditingChildInfo:(NSString*)profileCode withChild:(NSString*)childID Name:(NSString*)childname Sex:(NSString*)sex BirthDay:(NSString*)bd{
    
    return true;
}


- (bool) AddNewChildInfo:(NSString*)profileCode withChild:(NSString *)childID Name:(NSString *)childname Sex:(NSString *)sex BirthDay:(NSString *)bd{
    return true;
}

- (NSArray*) GetCustomerDetailEditHobbyInfo:(NSString*)profileCode withHobby:(NSString *)hobbyID{
    
    NSString* hobbyType = [NSString stringWithFormat:@"Swim"];
    NSString* description = [NSString stringWithFormat:@"sea"];
    
    NSArray* aa = [[NSArray alloc] initWithObjects:hobbyType,description, nil];

    return aa;
}

- (bool) SaveEditingHobbyInfo:(NSString*)profileCode withHobby:(NSString *)hobbyID Type:(NSString *)hobbyType Description:(NSString *)desc{
    return true;
}

- (bool) AddNewHobbyInfo:(NSString*)profileCode withHobby:(NSString *)hobbyID Type:(NSString *)hobbyType Description:(NSString *)desc{
    return true;
}

- (NSArray*) GetHobbyList{
    NSString* hobby1 = [NSString stringWithFormat:@"h1"];
    NSString* hobby2 = [NSString stringWithFormat:@"h2"];
    NSString* hobby3 = [NSString stringWithFormat:@"h3"];
    NSString* hobby4 = [NSString stringWithFormat:@"h4"];
    
    NSArray* aa = [[NSArray alloc] initWithObjects:hobby1,hobby2,hobby3,hobby4, nil];
    
    return aa;
}

- (NSArray*) GetCustomerDetailEditWorkplaceDetail:(NSString*)profileCode withWorkplace:(NSString *)workplaceID{
    
    NSString* hospital = [NSString stringWithFormat:@"ere"];
    NSString* department = [NSString stringWithFormat:@"dd"];
    NSString* building = [NSString stringWithFormat:@"xx"];
    NSString* workTime = [NSString stringWithFormat:@"afternoon"];
    
    NSArray* aa = [[NSArray alloc] initWithObjects:hospital,department,building,workTime, nil];
    
    
    return aa;
}

- (bool) SaveEditingWorkplaceDetail:(NSString*)profileCode withWorkplace:(NSString *)workplaceID Hospital:(NSString *)hospitalName Department:(NSString *)DepartName Building:(NSString *)buildingName WorkTime:(NSString *)worktime{
    return true;
}

- (bool) AddNewWorkplaceDetail:(NSString*)profileCode withWorkplace:(NSString *)workplaceID Hospital:(NSString *)hospitalName Department:(NSString *)DepartName Building:(NSString *)buildingName WorkTime:(NSString *)worktime{
    return true;
}

@end
