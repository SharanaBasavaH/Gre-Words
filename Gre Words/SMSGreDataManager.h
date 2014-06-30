//
//  SMSGreDataManager.h
//  Gre Words
//
//  Created by Sharana Basava on 3/27/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSGreItem.h"
#import "SMSGreGroup.h"
#import "SMSGreDataModelManager.h"
#import "Word.h"
#import "SMSGreNewWord.h"

#define ALL_WORDS_GROUP @"All Words"
#define FAVOURITE_GROUP @"Favourites"



@interface SMSGreDataManager : NSObject {
   // SMSGreDataModelManager *dataModelManager;
}

@property (nonatomic,retain) NSMutableArray *greWordsarray;
@property (nonatomic,retain) NSMutableArray *greGroupsarray;
@property (nonatomic,assign) int selectedGroupIndex;
@property (nonatomic,assign) int selectedWordIndex;
@property (nonatomic,retain) NSMutableString *selectedGroupName;
@property (assign,nonatomic) BOOL bDisplaySearchWord;
@property (assign,nonatomic) BOOL bDisplayWord;
@property (assign,nonatomic) BOOL bDisplayGroupWord;
@property (nonatomic,assign) int selectedTabBarIndex;






+(id)              sharedDataManager;
-(void)            getGreGroups;
-(NSMutableArray*) getWordsForselectedGroup;
-(void)            addWordToGroup:(Word*) word inGroup:(NSString*) gropuName;
-(void)            getWordsForGroup:(NSString*) groupName;
-(void)            saveToCoreData;
-(void)            searchWord:(NSString*) searchText;
-(void)            addWord:(SMSGreNewWord*) newWord;
-(void)            getWordsForFavourite;


@end
