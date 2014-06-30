//
//  Word.h
//  Gre Words
//
//  Created by Sharana Basava on 4/3/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Groups;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * adj;
@property (nonatomic, retain) NSString * adjDescription;
@property (nonatomic, retain) NSString * noun;
@property (nonatomic, retain) NSString * nounDescription;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSString * verbDescription;
@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSSet *groupRelation;
@end

@interface Word (CoreDataGeneratedAccessors)

- (void)addGroupRelationObject:(Groups *)value;
- (void)removeGroupRelationObject:(Groups *)value;
- (void)addGroupRelation:(NSSet *)values;
- (void)removeGroupRelation:(NSSet *)values;

@end
