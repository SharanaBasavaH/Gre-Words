//
//  SMSGreDataManager.m
//  Gre Words
//
//  Created by Sharana Basava on 3/27/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreDataManager.h"
#import "Word.h"
#import "Groups.h"



@implementation SMSGreDataManager


+ (id)sharedDataManager
{
    static id sharedDataManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedDataManager = [[self alloc] init];
        [sharedDataManager createInitialDb];
        [sharedDataManager getGreGroups];


    });
    return sharedDataManager;
}

-(void) createInitialDb {
    
    NSURL *destinationURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WordsCoreDataModel.sqlite"];
    NSError *err;
    if ([destinationURL checkResourceIsReachableAndReturnError:&err] == NO) {
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *myFile = [mainBundle pathForResource: @"GRE_Words" ofType: @"csv"];
        
        
        NSMutableArray *words = [[NSMutableArray alloc] initWithContentsOfFile:myFile];
        
        
        [words enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSManagedObject *newContact;
            newContact = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Word"
                          inManagedObjectContext:[[SMSGreDataModelManager sharedDataModel] managedObjectContext]];
            
            [newContact setValue:[obj objectForKey:adjKey] forKey:adjKey];
            [newContact setValue:[obj objectForKey:@"Synonym"] forKey:verbKey];
            [newContact setValue:[obj objectForKey:nounKey] forKey:nounKey];
            [newContact setValue:[obj objectForKey:@"Description"] forKey:verbDescriptionKey];
            [newContact setValue:[obj objectForKey:nounDescriptionKey] forKey:nounDescriptionKey];
            [newContact setValue:[obj objectForKey:adjDescriptionKey] forKey:adjDescriptionKey];
            [newContact setValue:[obj objectForKey:@"Word"] forKey:wordKey];
            [newContact setValue:[NSNumber numberWithBool:FALSE] forKey:favouriteKey];

            
            
            
            NSError *error;
            if (![[[SMSGreDataModelManager sharedDataModel] managedObjectContext] save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
        }];
    }
}


- (void) getGreGroups {
        
    NSError *error;
    NSArray *groupsarray              = nil;
    SMSGreDataModelManager *dataModelManager = [SMSGreDataModelManager sharedDataModel];
    NSManagedObjectContext *context          = [dataModelManager managedObjectContext];
    NSEntityDescription *entityDesc          = [NSEntityDescription entityForName:@"Groups" inManagedObjectContext:context];
    NSFetchRequest *request                  = [[NSFetchRequest alloc] init];
    
    if(_greGroupsarray == nil)
        _greGroupsarray = [[NSMutableArray alloc] init];
    else
        [_greGroupsarray
         removeAllObjects];
    
    
    
    [self getWordsForGroup:ALL_WORDS_GROUP];
    SMSGreGroup *allGroup = [[SMSGreGroup alloc] init];
    allGroup.groupName = ALL_WORDS_GROUP;
    allGroup.numberOfWordsinGroup = [NSString stringWithFormat:@"%tu", [_greWordsarray count]];
    allGroup.testResult = @"NA";
    [_greGroupsarray addObject:allGroup];
    
    [self getWordsForFavourite];
    SMSGreGroup *favObj = [[SMSGreGroup alloc] init];
    favObj.groupName = FAVOURITE_GROUP;
    favObj.numberOfWordsinGroup = [NSString stringWithFormat:@"%tu", [_greWordsarray count]];
    favObj.testResult = @"NA";
    [_greGroupsarray addObject:favObj];

    
    [request setEntity:entityDesc];
    groupsarray  = [context executeFetchRequest:request error:&error];
    
    if(groupsarray!= nil && groupsarray.count) {
        for(int i=0; i< groupsarray.count ;i ++) {
            
            SMSGreGroup *obj = [[SMSGreGroup alloc] init];
            Groups *group = [groupsarray objectAtIndex:i];
            
            obj.groupName =group.groups;
            NSSet *words = group.wordRelation;
            
            obj.numberOfWordsinGroup = [NSString stringWithFormat:@"%tu", words.count];
            obj.testResult = @"NA";
            [_greGroupsarray addObject:obj];
        }
        
    }
    
    
}


- (NSMutableArray*) getWordsForselectedGroup {
    if(self.selectedGroupIndex == 0)
        return self.greWordsarray;
    return nil;
}

-(void) getWordsForFavourite {
    
    NSError *error                           = nil;
    SMSGreDataModelManager *dataModelManager = [SMSGreDataModelManager sharedDataModel];
    NSManagedObjectContext *context          = [dataModelManager managedObjectContext];
    NSEntityDescription *entityDesc          = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    NSFetchRequest *request                  = [[NSFetchRequest alloc] init];
    NSPredicate *pred                        = [NSPredicate predicateWithFormat:@"(favourite = %@)", [NSNumber numberWithBool:TRUE]];
    
    [request setEntity:entityDesc];
    [request setPredicate:pred];
    
    if(_greWordsarray == nil)
        _greWordsarray = [[NSMutableArray alloc] init];
    else
        [_greWordsarray removeAllObjects];
    
    _greWordsarray  = [(NSMutableArray*)[context executeFetchRequest:request error:&error] mutableCopy];

}



-(void) getWordsForGroup:(NSString*) groupName {
    
    if(!(groupName && groupName.length >0))
        return;
    
    NSPredicate *pred;
    
    
    if(([groupName isEqualToString:FAVOURITE_GROUP])) {
        
        
        NSError *error;
        SMSGreDataModelManager *dataModelManager = [SMSGreDataModelManager sharedDataModel];
        NSManagedObjectContext *context          = [dataModelManager managedObjectContext];
        NSEntityDescription *entityDesc          = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
        NSFetchRequest *request                  = [[NSFetchRequest alloc] init];
        pred = [NSPredicate predicateWithFormat:@"(favourite = %d)", 1];
        
        [request setEntity:entityDesc];
        [request setPredicate:pred];
        
        
        if(_greWordsarray == nil)
            _greWordsarray = [[NSMutableArray alloc] init];
        else
            [_greWordsarray removeAllObjects];
        
        
        _greWordsarray  = [(NSMutableArray*)[context executeFetchRequest:request error:&error] mutableCopy];
        
        
        
    }
    else if(![groupName isEqualToString:ALL_WORDS_GROUP]) {
        NSError *error                           = nil;
        NSMutableArray *groupsarray              = nil;
        SMSGreDataModelManager *dataModelManager = [SMSGreDataModelManager sharedDataModel];
        NSManagedObjectContext *context          = [dataModelManager managedObjectContext];
        NSEntityDescription *entityDesc          = [NSEntityDescription entityForName:@"Groups" inManagedObjectContext:context];
        NSFetchRequest *request                  = [[NSFetchRequest alloc] init];
        
        
        if(_greWordsarray == nil)
            _greWordsarray = [[NSMutableArray alloc] init];
        else
            [_greWordsarray removeAllObjects];
        
        
        pred = [NSPredicate predicateWithFormat:@"(groups = %@)", groupName];
        
        
        
        [request setEntity:entityDesc];
        [request setPredicate:pred];
        
        
        groupsarray  = (NSMutableArray*)[context executeFetchRequest:request error:&error];
        
        if(groupsarray!= nil && groupsarray.count) {
            Groups *group = [groupsarray objectAtIndex:0];
            _greWordsarray = [NSMutableArray arrayWithArray:group.wordRelation.allObjects];
            
        }
        
    }
    else
        [self getAllWords];
}

-(void) getAllWords {
    NSError *error;
    SMSGreDataModelManager *dataModelManager = [SMSGreDataModelManager sharedDataModel];
    NSManagedObjectContext *context          = [dataModelManager managedObjectContext];
    NSEntityDescription *entityDesc          = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    NSFetchRequest *request                  = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    if(_greWordsarray == nil)
        _greWordsarray = [[NSMutableArray alloc] init];
    else
        [_greWordsarray removeAllObjects];
    

    _greWordsarray  = [(NSMutableArray*)[context executeFetchRequest:request error:&error] mutableCopy];


    
}

-(void) saveToCoreData {
    NSError *error;
    if (![[[SMSGreDataModelManager sharedDataModel] managedObjectContext] save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

-(void) addWordToGroup:(Word*) word inGroup:(NSString*) groupName {
    if(!(groupName && groupName.length >0))
        return;
    NSError *error                           = nil;
    NSMutableArray *groupsarray              = nil;
    SMSGreDataModelManager *dataModelManager = [SMSGreDataModelManager sharedDataModel];
    NSManagedObjectContext *context          = [dataModelManager managedObjectContext];
    NSEntityDescription *entityDesc          = [NSEntityDescription entityForName:@"Groups" inManagedObjectContext:context];
    NSFetchRequest *request                  = [[NSFetchRequest alloc] init];
    NSPredicate *pred                        = [NSPredicate predicateWithFormat:@"(groups = %@)", groupName];
    
    [request setEntity:entityDesc];
    [request setPredicate:pred];
    
    groupsarray  = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    
    if(groupsarray!= nil && groupsarray.count) {
        [word addGroupRelationObject:groupsarray[0]];
    }
    else {
        Groups* product = [NSEntityDescription insertNewObjectForEntityForName: @"Groups" inManagedObjectContext: [[SMSGreDataModelManager sharedDataModel] managedObjectContext]];
        product.groups = groupName;
        [word addGroupRelationObject:product];
    }
}

-(void) searchWord:(NSString*) searchText {
    if(!(searchText && searchText.length >0))
        return;
    
    NSError *error                           = nil;
    SMSGreDataModelManager *dataModelManager = [SMSGreDataModelManager sharedDataModel];
    NSManagedObjectContext *context          = [dataModelManager managedObjectContext];
    NSEntityDescription *entityDesc          = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    NSFetchRequest *request                  = [[NSFetchRequest alloc] init];
    
    NSPredicate *pred  = [NSPredicate predicateWithFormat:@"word CONTAINS[c] %@", searchText];
    
    [request setEntity:entityDesc];
    [request setPredicate:pred];
    
    if(_greWordsarray == nil)
        _greWordsarray = [[NSMutableArray alloc] init];
    else
        [_greWordsarray removeAllObjects];
    
    _greWordsarray  = [(NSMutableArray*)[context executeFetchRequest:request error:&error] mutableCopy];
}

-(void) addWord:(SMSGreNewWord*) newWord  {
    if(newWord.word.length == 0)
        return;
    
    Word* word = [NSEntityDescription insertNewObjectForEntityForName: @"Word" inManagedObjectContext: [[SMSGreDataModelManager sharedDataModel] managedObjectContext]];

    word.word =[newWord.word mutableCopy];
    word.verb = [newWord.verb mutableCopy];
    word.verbDescription = [newWord.verbDescription mutableCopy];
    word.noun = [newWord.noun mutableCopy];
    word.nounDescription = [newWord.nounDescription mutableCopy];
    word.adj = [newWord.adj mutableCopy];
    word.adjDescription = [newWord.adjDescription mutableCopy];
    word.favourite = [newWord.favourite mutableCopy];

    
    [self saveToCoreData];
    
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
