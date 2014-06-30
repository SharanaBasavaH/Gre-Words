//
//  SMSGreDataModelManager.h
//  Gre Words
//
//  Created by Sharana Basava on 4/1/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


#define adjKey             @"adj"
#define adjDescriptionKey  @"adjDescription"
#define nounKey            @"noun"
#define nounDescriptionKey @"nounDescription"
#define verbKey            @"verb"
#define verbDescriptionKey @"verbDescription"
#define wordKey            @"word"
#define favouriteKey       @"favourite"



@interface SMSGreDataModelManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id)sharedDataModel;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
