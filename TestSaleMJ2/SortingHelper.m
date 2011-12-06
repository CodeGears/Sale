//
//  SortingHelper.m
//  Scribe Direct Mobile
//
//  Created by Kris Bray on 11-01-21.
//  Copyright 2011 Imperium. All rights reserved.
//

#import "SortingHelper.h"


@implementation SortingHelper

-(void)sortArrayContainingDictionaryItemsByKey:(NSString *)keyName ArrayToSort:(id)arrayToSort Ascending:(BOOL)asc isNumeric:(BOOL)isNumeric
{
	
	NSMutableArray *unsortedValues = [[NSMutableArray alloc] init];
	NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
	NSUInteger i,e;
	
	for (i=0; i<[arrayToSort count]; i++) {
		[unsortedValues addObject:[[arrayToSort objectAtIndex:i] objectForKey:keyName]];
	}
	
	//NSArray *sortedValues = [unsortedValues sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	NSSortDescriptor *sortDesc;
	if(isNumeric == YES){
		sortDesc = [[NSSortDescriptor alloc] initWithKey:nil ascending:asc selector:@selector(compare:)];
	}
	else {
		sortDesc = [[NSSortDescriptor alloc] initWithKey:nil ascending:asc selector:@selector(caseInsensitiveCompare:)];
	}
	
	NSMutableArray *sortedValues = [NSMutableArray arrayWithArray:[unsortedValues sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]]];
	//remove duplicates
	NSArray *copy = [sortedValues copy];
	NSInteger index = [copy count] - 1;
	for (id object in [copy reverseObjectEnumerator]) {
		if ([sortedValues indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
			[sortedValues removeObjectAtIndex:index];
		}
		index--;
	}
	[copy release];
	
	
	NSLog(@"%@", unsortedValues, nil);
	NSLog(@"%@", sortedValues, nil);
	
	NSMutableDictionary *dupCount = [[NSMutableDictionary alloc] init];
	
	for (i=0; i<[sortedValues count]; i++) {
		//loop through each sorted item
		NSInteger newcnt = 0;//reset newcnt for duplicates
		for (e=0; e<[arrayToSort count]; e++) {
			//set duplicate counter
			if (!isNumeric) {
				//find the matching 
				NSString *avalue = [[NSString alloc] initWithString:[[arrayToSort objectAtIndex:e] objectForKey:keyName]];
				if ([avalue isEqualToString:(NSString *)[sortedValues objectAtIndex:i]])
				{
					
					NSInteger cnt = (NSInteger)[dupCount objectForKey:avalue];
					
					//this has been found previously we need to skip this index if we are not at the matchign duplciate position
					if (newcnt == cnt || cnt == 0) {
						//this is the right record to add
						cnt++;
						
						[dupCount setObject:[NSString stringWithFormat:@"%d", cnt, nil] forKey:avalue];
						[sortedArray addObject:[arrayToSort objectAtIndex:e]];
						[avalue release];
						break;//break out in case there are duplicate matches
					}else {
						//this is the wrong record skip over this one
						newcnt++;
						
					}		
				}
				[avalue release];
			}
			else {
				
				//find the matching 
				NSNumber *avalue = [[NSNumber alloc] initWithInt:[[[arrayToSort objectAtIndex:e] objectForKey:keyName] intValue]];
				if ([avalue intValue] == [[sortedValues objectAtIndex:i] intValue])
				{
					[sortedArray addObject:[arrayToSort objectAtIndex:e]];
				}
				
				
			}
			
		}
		
	}
	[dupCount release];
	for (i=0; i<[sortedArray count]; i++) {
		
		
		if ([[[[arrayToSort objectAtIndex:i] allValues] objectAtIndex:0] intValue] != [[[[sortedArray objectAtIndex:i] allValues] objectAtIndex:0] intValue]) {
			[arrayToSort replaceObjectAtIndex:i withObject:[sortedArray objectAtIndex:i]];
		}
	}
	NSLog(@"%@", arrayToSort, nil);
	[sortDesc release];
	[unsortedValues release];
	[sortedArray release];
}

@end
