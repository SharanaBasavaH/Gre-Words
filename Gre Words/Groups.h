//
//  Groups.h
//  Gre Words
//
//  Created by Sharana Basava on 4/3/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface Groups : NSManagedObject

@property (nonatomic, retain) NSString * groups;
@property (nonatomic, retain) NSSet *wordRelation;
@end

@interface Groups (CoreDataGeneratedAccessors)

- (void)addWordRelationObject:(Word *)value;
- (void)removeWordRelationObject:(Word *)value;
- (void)addWordRelation:(NSSet *)values;
- (void)removeWordRelation:(NSSet *)values;

@end
