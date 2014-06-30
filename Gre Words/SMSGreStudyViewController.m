//
//  SMSGreStudyViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 3/27/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreStudyViewController.h"
#import "SMSGreDataManager.h"
#import "SMSGreDescriptionViewController.h"
#import "SMSGreEditWordViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SMSAppDelegate.h"



enum Tag {
    nTextViewTag = 1,
    vTextViewTag = 2,
    adjTextViewTag = 3,
    
    nDescriptionTag = 11,
    vDescriptionag = 22,
    adjDescriptionTag = 33,
    
    nEditTag = 111,
    vEditTag = 222,
    adjEditTag = 333
    
};

static bool bGroupsTabSelected;
static bool bWordsTabSelected;
static bool bSearchTabSelected;



@interface SMSGreStudyViewController () {
    SMSGreDataManager *datamanager;
}
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITextView *verbTextView;
@property (weak, nonatomic) IBOutlet UIButton *vEditButton;
@property (weak, nonatomic) IBOutlet UITextView *vDesTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollVeiw;
@property (weak, nonatomic) IBOutlet UILabel *vLabel;
@property (weak, nonatomic) IBOutlet UILabel *vDLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteBarButton;

@end
static NSMutableArray *wordsForStudy;
static SMSGreItem *item;

static int studySelectedIndex;
//static int wordSelectedIndex;
static int displayedIndex;
//static   NSUInteger is = 1000;
//static   NSUInteger was = 1000;


static UIImage         *favoriteImage;
static UIImage         *unFavoriteImage;


@implementation SMSGreStudyViewController {
    UITabBarController *tabBar;
}
-(IBAction)unWindStudyView:(UIStoryboardSegue*)segue {
    //SMSGreEditWordViewController *obj = [segue sourceViewController];
    //[self setTextatIndex:datamanager.selectedWordIndex];
    [self setTextForword];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[SMSAppDelegate appDelegate] setNavigationBarBackGroundColor:self.navigationController];

    datamanager = [SMSGreDataManager sharedDataManager];
    self.view.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    
    bGroupsTabSelected = FALSE;
    bWordsTabSelected  = FALSE;
    bSearchTabSelected = FALSE;
    
    favoriteImage   = [UIImage imageNamed:@"thumbnail-favorite.png"];
    unFavoriteImage = [UIImage imageNamed:@"toolbar-favourite.png"];
    
    self.favoriteBarButton.image = unFavoriteImage;
    if(datamanager.selectedTabBarIndex == 0)  { //groups
        studySelectedIndex = datamanager.selectedWordIndex;
        if([datamanager.selectedGroupName isEqualToString:FAVOURITE_GROUP])
            [datamanager getWordsForFavourite];
        else
            [datamanager getWordsForGroup:datamanager.selectedGroupName];
        
        wordsForStudy = datamanager.greWordsarray;
        displayedIndex = studySelectedIndex;
        [self setTextForword];
    }
    else if(datamanager.selectedTabBarIndex  == 1) //Words
    {
        bWordsTabSelected = TRUE;
        [self setTextForword];
    }
    else if(datamanager.selectedTabBarIndex  == 2) // Search
    {
        bSearchTabSelected = TRUE;
        [self setTextForword];
    }
    
    if(displayedIndex == 0)
        [self.previousButton setEnabled:NO];
    if(wordsForStudy.count == displayedIndex + 1)
        [self.nextButton setEnabled:NO];
    
    _vEditButton.frame = CGRectMake(self.view.frame.size.width/2 - _vEditButton.frame.size.width/2, _vEditButton.frame.origin.y, _vEditButton.frame.size.width, _vEditButton.frame.size.height);
    
    
    //To make the border look very close to a UITextField
    [_verbTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_verbTextView.layer setBorderWidth:1.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    _verbTextView.layer.cornerRadius = 5;
    _verbTextView.clipsToBounds      = YES;
    _verbTextView.backgroundColor    = [SMSAppDelegate appDelegate].backGroundColor;

    
    
    [_vDesTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_vDesTextView.layer setBorderWidth:1.0];
    _vDesTextView.layer.cornerRadius = 5;
    _vDesTextView.clipsToBounds      = YES;
    _vDesTextView.backgroundColor    = [SMSAppDelegate appDelegate].backGroundColor;

    if(datamanager.selectedTabBarIndex != 0) {
        [self.previousButton setHidden:YES];
        [self.nextButton setHidden:YES];
    }
    else{
        UISwipeGestureRecognizer * swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nextAction:)];
        swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:swipeleft];
        
        UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(previousAction:)];
        swiperight.direction=UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:swiperight];
        
    }
    self.scrollVeiw.frame = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;

    _wordLabel.frame    =  _wordLabel.frame = CGRectMake(_wordLabel.frame.origin.x, _wordLabel.frame.origin.y, screenWidth - _wordLabel.frame.origin.x - 10, _wordLabel.frame.size.height);
    _verbTextView.frame = CGRectMake(_verbTextView.frame.origin.x,_verbTextView.frame.origin.y, screenWidth - _verbTextView.frame.origin.x - 10, _verbTextView.frame.size.height);
    _vDesTextView.frame = CGRectMake(_vDesTextView.frame.origin.x , _vDesTextView.frame.origin.y, screenWidth - _vDesTextView.frame.origin.x - 10, _vDesTextView.frame.size.height);
}


-(void) viewWillAppear:(BOOL)animated {
    if([datamanager.selectedGroupName isEqualToString:FAVOURITE_GROUP])
        [datamanager getWordsForFavourite];
    else
        [datamanager getWordsForGroup:datamanager.selectedGroupName];
    wordsForStudy = datamanager.greWordsarray;
}
-(void) viewWillDisappear:(BOOL)animated {
    
    
    if(tabBar.selectedIndex == 0) //groups
    {
        studySelectedIndex = displayedIndex;
    }
}

- (void)viewDidAppear:(BOOL)animated   // Called when the view has been fully transitioned onto the screen. Default does nothing
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)previousAction:(id)sender {
    
    if(displayedIndex == 0) {
        [self.previousButton setEnabled:NO];
        return;
    }
    displayedIndex--;
    
    if(displayedIndex == 0)
       [self.previousButton setEnabled:NO];
    
    [self.nextButton setEnabled:YES];
    [self setTextForword];
}

-(IBAction)nextAction:(id)sender {
    if(displayedIndex == [wordsForStudy count] - 1){
        [self.nextButton setEnabled:NO];
        return;
    }
    
    displayedIndex++;
    if(displayedIndex == [wordsForStudy count] - 1)
        [self.nextButton setEnabled:NO];
    
    [self.previousButton setEnabled:YES];
    [self setTextForword];
}

-(IBAction)favButtonAction:(id)sender {
    
    if(datamanager.selectedTabBarIndex == 0) {
        if(wordsForStudy.count == 1)
            item = wordsForStudy[0];
        else
            item = [wordsForStudy objectAtIndex:displayedIndex];
    }
    else if(datamanager.bDisplaySearchWord && bSearchTabSelected) {
        item = (SMSGreItem*)self.selectedSearchWord;
    }
    else if(datamanager.bDisplayWord && bWordsTabSelected) {
        item = (SMSGreItem*)self.selectedWordToDisplay;
    }
    
    
    if(item.favourite.intValue == 0 ) {
        item.favourite = [NSNumber numberWithBool:TRUE];
        self.favoriteBarButton.image = favoriteImage;
    }
    
    else if(item.favourite.intValue == 1) {
        item.favourite = [NSNumber numberWithBool:FALSE];
        self.favoriteBarButton.image = unFavoriteImage;
    }
    [[SMSGreDataManager sharedDataManager] saveToCoreData];
}

- (CGFloat)measureHeightOfUITextView:(UITextView *)textView
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        // This is the code for iOS 7. contentSize no longer returns the correct value, so
        // we have to calculate it.
        //
        // This is partly borrowed from HPGrowingTextView, but I've replaced the
        // magic fudge factors with the calculated values (having worked out where
        // they came from)
        
        CGRect frame = textView.bounds;
        
        // Take account of the padding added around the text.
        
        UIEdgeInsets textContainerInsets = textView.textContainerInset;
        UIEdgeInsets contentInsets = textView.contentInset;
        
        CGFloat leftRightPadding = textContainerInsets.left + textContainerInsets.right + textView.textContainer.lineFragmentPadding * 2 + contentInsets.left + contentInsets.right;
        CGFloat topBottomPadding = textContainerInsets.top + textContainerInsets.bottom + contentInsets.top + contentInsets.bottom;
        
        frame.size.width -= leftRightPadding;
        frame.size.height -= topBottomPadding;
        
        NSString *textToMeasure = textView.text;
        if ([textToMeasure hasSuffix:@"\n"])
        {
            textToMeasure = [NSString stringWithFormat:@"%@-", textView.text];
        }
        
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName: textView.font, NSParagraphStyleAttributeName : paragraphStyle };
        
        CGRect size = [textToMeasure boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        
        CGFloat measuredHeight = ceilf(CGRectGetHeight(size) + topBottomPadding);
        return measuredHeight;
    }
    else
    {
        return textView.contentSize.height;
    }
}
-(void) setTextForword {
    
    
    [self.wordLabel setHidden:NO];
    
    if(datamanager.selectedTabBarIndex == 0) {
        if(wordsForStudy.count == 1)
            item = wordsForStudy[0];
        else
            item = [wordsForStudy objectAtIndex:displayedIndex];
    }
    else if(datamanager.bDisplaySearchWord && bSearchTabSelected) {
        item = (SMSGreItem*)self.selectedSearchWord;
    }
    else if(datamanager.bDisplayWord && bWordsTabSelected) {
        item = (SMSGreItem*)self.selectedWordToDisplay;
    }
    else
        return;
    
    self.navigationItem.title = item.word;
    
    _verbTextView.editable = YES;
    [_verbTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
    _verbTextView.editable = NO;
    
    _vDesTextView.editable = YES;
    [_vDesTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
    _vDesTextView.editable = NO;
    
    [self.wordLabel setText:item.word];
    [self.verbTextView setText:item.verb];
    [self.vDesTextView setText:item.verbDescription];
    
    int        gapHeight = 5;
    CGFloat       height =  self.navigationController.navigationBar.frame.size.height + 25;
    CGRect     textViewFrame;
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        _wordLabel.frame = CGRectMake(_wordLabel.frame.origin.x,height, _wordLabel.frame.size.width, _wordLabel.frame.size.height);
    }
    
    if(self.wordLabel.text.length) {
        height += gapHeight + _wordLabel.frame.size.height + (gapHeight * 5);
    }
    
    if(item.verb.length) {
        [self.vLabel setHidden:NO];
        [self.verbTextView setHidden:NO];
        
        _vLabel.frame = CGRectMake(_vLabel.frame.origin.x, height, _vLabel.frame.size.width, _vLabel.frame.size.height);
        _vEditButton.frame = CGRectMake(_vEditButton.frame.origin.x, height, _vEditButton.frame.size.width, _vLabel.frame.size.height);
        height += gapHeight + _vLabel.frame.size.height;
        
        CGFloat verbTextViewHeight =[self measureHeightOfUITextView:_verbTextView];
        textViewFrame = _verbTextView.frame;
        _verbTextView.frame = CGRectMake(textViewFrame.origin.x, height, textViewFrame.size.width, verbTextViewHeight);
        height += gapHeight + verbTextViewHeight;
    }
    else {
        [self.verbTextView setHidden:YES];
        [self.vLabel setHidden:YES];
    }
    
    if(item.verbDescription.length) {
        [self.vDLabel setHidden:NO];
        [self.vDesTextView setHidden:NO];
        
        _vDLabel.frame = CGRectMake(_vDLabel.frame.origin.x, height, _vDLabel.frame.size.width, _vDLabel.frame.size.height);
        height += 5 + _vDLabel.frame.size.height;
        
        CGFloat adjTextViewHeight = [self measureHeightOfUITextView:_vDesTextView];
        textViewFrame = _vDesTextView.frame;
        _vDesTextView.frame = CGRectMake(textViewFrame.origin.x, height, textViewFrame.size.width, adjTextViewHeight);
        height += gapHeight + adjTextViewHeight;
    }
    else {
        [self.vDesTextView setHidden:YES];
        [self.vDLabel setHidden:YES];
    }
    
    if([self.vLabel isHidden]) {
        _vEditButton.frame = CGRectMake(self.view.frame.size.width/2 - _vEditButton.frame.size.width/2, height, _vEditButton.frame.size.width, _vEditButton.frame.size.height);
        height += gapHeight + _vEditButton.frame.size.height;
        
    }
    
    //Next button
    self.nextButton.frame = CGRectMake(self.nextButton.frame.origin.x, height,  self.nextButton.frame.size.width,  self.nextButton.frame.size.height);
    
    //Previous Button
    self.previousButton.frame = CGRectMake(self.previousButton.frame.origin.x, height,  self.previousButton.frame.size.width,  self.previousButton.frame.size.height);
    
    if(height > self.view.frame.size.height)
        self.scrollVeiw.contentSize = CGSizeMake(self.view.frame.size.width, height + 50);
    else
        self.scrollVeiw.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 20);
    
    [self.scrollVeiw setContentOffset:CGPointMake(self.scrollVeiw.contentOffset.x, -60) animated:YES];
    
    if(item.favourite.intValue == 0 ) {
        self.favoriteBarButton.image = unFavoriteImage;
    }
    else if(item.favourite.intValue == 1) {
        self.favoriteBarButton.image = favoriteImage;
    }
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if (sender == self.nEditButton || sender == self.vEditButton || sender == self.adjEditButton) {
        
        SMSGreEditWordViewController *vc = [segue destinationViewController];
        vc.itemToEdit = item;
       // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void) dealloc {
    //[tabBar removeObserver:self forKeyPath:@"selectedItem" context:nil];
}


@end


