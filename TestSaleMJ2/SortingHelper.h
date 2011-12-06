//
//  SortingHelper.h
//  Scribe Direct Mobile
//
//  Created by Kris Bray on 11-01-21.
//  Copyright 2011 Imperium. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SortingHelper : NSObject {

}
-(void)sortArrayContainingDictionaryItemsByKey:(NSString *)keyName ArrayToSort:(id)arrayToSort Ascending:(BOOL)asc isNumeric:(BOOL)isNumeric;
@end
