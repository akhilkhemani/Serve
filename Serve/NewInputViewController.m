//
//  NewInputViewController.m
//  Serve
//
//  Created by Akhil Khemani on 5/19/15.
//  Copyright (c) 2015 Akhil Khemani. All rights reserved.
//

#import "NewInputViewController.h"
#import "PickUpInfoViewController.h"
#import "PickImageViewController.h"

#define MAIN_SCREEN_HEIGHT [[UIScreen mainScreen].bounds.size.height]

//const CGFloat imageViewHeight = 160.0f;
const CGFloat imageViewHeightPercent = 0.15f;

const CGFloat formRightMargin = 0.95f;
const CGFloat formLeftMargin = .7f;

const CGFloat formTopMargin = 100.0f;
//const CGFloat formBottomMargin = -70.0f;
const CGFloat formBottomMargin = .90f;

const CGFloat formInputViewHeight = 30.0f;
const CGFloat formLabelToLabelOffset = 20.0f;
const CGFloat formLabelToFieldOffset = 70.0f;

const CGFloat formFieldToFieldOffsetPercent = 0.02;

const CGFloat formFieldHeight = 20.0f;
const CGFloat buttonOffsetFromInputLeft = 5.0f;
const CGFloat specialButtonToInputViewLeftOffset = 20.0f;
const CGFloat specialButtonToInputViewRightOffset = -specialButtonToInputViewLeftOffset;

const CGFloat cancelButtonTag = 1;
const CGFloat continueButtonTag = 1;

const CGFloat addPhotoTag = 2;
const CGFloat addImageBackgroundViewTag = 3;

static NSString * const titlePlaceholder = @"Title";
static NSString * const cuisinePlaceholder = @"Type2?";
static NSString * const descriptionPlaceholder = @"Description Text (Optional)";
static NSArray  * addPhotoActionSheetItems = nil;
static NSArray  * cancelButtonActionSheetItems = nil;

@interface NewInputViewController ()

@property (nonatomic, strong) UIView *progressIndicator;
@property (nonatomic, strong) UIImageView *addImageBackgroundView;
@property (nonatomic, strong) UIButton *addPhotoActionSheetButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *servesLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *cuisineLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UITextField *titleInput;
@property (nonatomic, strong) UITextView *servesInput;
@property (nonatomic, strong) UIButton *addServeButton;
@property (nonatomic, strong) UIButton *reduceServeButton;
@property (nonatomic, strong) UIButton *previousTypeButton;
@property (nonatomic, strong) UIButton *nextTypeButton;
@property (nonatomic, strong) UITextView *typeInput;
@property (nonatomic, strong) UITextView *descInput;
@property (nonatomic, strong) UITextField *cuisineInput;
@property (nonatomic, readwrite,assign) NSInteger numberOfServes;
@property (nonatomic, retain) NSArray* itemTypes;

@property (strong, nonatomic) PickUpInfoViewController *pickUpInfoViewController;
@property (strong, nonatomic) PickImageViewController *pickImageViewController;
@property (nonatomic, strong) UIActionSheet *addPhotoActionSheet;
@property (nonatomic, strong) UIActionSheet *cancelButtonActionSheet;


- (IBAction)continueButtonPressed:(id)sender;
- (void) showActionSheet:(id)sender;
- (IBAction) didTapButton:(id)sender;


@end

@implementation NewInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpViewControllerObjects];
    [self.view addSubview:self.addImageBackgroundView];
//    [self.view addSubview:self.addPhotoActionSheetButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleInput];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.descInput];
    [self.view addSubview:self.servesLabel];
    [self.view addSubview:self.servesInput];
//    [self.view addSubview:self.addServeButton];
//    [self.view addSubview:self.reduceServeButton];
    [self.view addSubview:self.typeLabel];
    [self.view addSubview:self.typeInput];
//    [self.view addSubview:self.previousTypeButton];
//    [self.view addSubview:self.nextTypeButton];
    [self.view addSubview:self.cuisineLabel];
    [self.view addSubview:self.cuisineInput];
    [self.view addSubview:self.progressIndicator];
    
    
    [self setUpNavigationController];
    [self setUpConstraintsNew];
    [self setUpActionSheets];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


-(void)setUpViewControllerObjects {
    
    //ADD PHOTO BIG BACKGROUND IMAGE
    self.addImageBackgroundView = [[UIImageView alloc]init];
    self.addImageBackgroundView.image = [UIImage imageNamed:@"food1-gray.jpg"];
    //self.addImageBackgroundView.alpha = 0.6f;
    self.addImageBackgroundView.layer.borderColor = [UIColor blackColor].CGColor;
    self.addImageBackgroundView.layer.borderWidth = 0.5f;
    self.addImageBackgroundView.layer.cornerRadius = 10;
    self.addImageBackgroundView.tag = 0;
    [self.addImageBackgroundView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageActionSheet:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.addImageBackgroundView addGestureRecognizer:singleTap];
    self.addImageBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.addPhotoActionSheetButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addPhotoActionSheetButton setImage:[UIImage imageNamed:@"camera-2.png"] forState:UIControlStateNormal];
    [self.addPhotoActionSheetButton addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    //[self.addPhotoActionSheetButton setFrame:CGRectMake(160.0f, 196.0f, 55.0f, 55.0f)];
    //    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-20, 55.0f, 90, 20)];
    //    [label setText:@"Add Photo"];
    //    [label setFont:[UIFont systemFontOfSize:11.0f]];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    [label setTextColor:[UIColor whiteColor]];
    //    [label setBackgroundColor:[UIColor clearColor]];
    //    [self.addPhotoActionSheetButton addSubview:label];
    self.addPhotoActionSheetButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.addPhotoActionSheetButton.tag = addPhotoTag;
    
    
    self.titleLabel  = [UILabel new];
    [self.titleLabel setText:@"*Title:"];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.servesLabel  = [UILabel new];
    [self.servesLabel setText:@"*Type2:"];
    [self.servesLabel setFont:[UIFont systemFontOfSize:14]];
    self.servesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.typeLabel  = [UILabel new];
    [self.typeLabel setText:@"*Type:"];
    [self.typeLabel setFont:[UIFont systemFontOfSize:14]];
    self.typeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.cuisineLabel = [UILabel new];
    [self.cuisineLabel setText:@"*Type3:"];
    [self.cuisineLabel setFont:[UIFont systemFontOfSize:14]];
    self.cuisineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.descLabel = [UILabel new];
    [self.descLabel setText:@"Desc:"];
    [self.descLabel setFont:[UIFont systemFontOfSize:14]];
    self.descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.titleInput = [[UITextField alloc]init];
    self.titleInput.tag = 1;
    self.titleInput.delegate = self;
    self.titleInput.textColor = [UIColor grayColor];
    self.titleInput.font = [UIFont systemFontOfSize:10];
    self.titleInput.textAlignment = NSTextAlignmentCenter;
    [self.titleInput setReturnKeyType:UIReturnKeyDone];
    self.titleInput.text = titlePlaceholder;
    //[self setTextFieldProperties:self.titleInput];
    self.titleInput.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleInput.layer.borderWidth = .5f;
    self.titleInput.layer.borderColor = [[UIColor grayColor] CGColor];
    self.titleInput.layer.cornerRadius = 5;//changed from 15
    //self.titleInput.clipsToBounds = YES;
    
    self.servesInput = [[UITextView alloc]init];
    self.servesInput.text = [NSString stringWithFormat:@"%ld",self.numberOfServes];//this has to be a property counting serves
    self.servesInput.textColor = [UIColor blackColor];
    self.servesInput.textAlignment = NSTextAlignmentCenter;
    self.servesInput.editable = NO;
    self.servesInput.translatesAutoresizingMaskIntoConstraints = NO;
    self.servesInput.layer.borderWidth = .5f;
    self.servesInput.layer.borderColor = [[UIColor grayColor] CGColor];
    self.servesInput.layer.cornerRadius = 5;//changed from 15
    self.servesInput.clipsToBounds = YES;
    
    self.typeInput = [[UITextView alloc]init];
    self.typeInput.text = [self.itemTypes objectAtIndex:0];//default item type is veg
    self.typeInput.textColor = [UIColor blackColor];
    self.typeInput.textAlignment = NSTextAlignmentCenter;
    self.typeInput.editable = NO;
    self.typeInput.translatesAutoresizingMaskIntoConstraints = NO;
    self.typeInput.layer.borderWidth = .5f;
    self.typeInput.layer.borderColor = [[UIColor grayColor] CGColor];
    self.typeInput.layer.cornerRadius = 5;//changed from 15
    self.typeInput.clipsToBounds = YES;
    
    self.cuisineInput = [[UITextField alloc]init];
    self.cuisineInput.text = cuisinePlaceholder;//default item type is veg
    self.cuisineInput.textColor = [UIColor grayColor];
    self.cuisineInput.textAlignment = NSTextAlignmentCenter;
    self.cuisineInput.tag = 2;
    self.cuisineInput.delegate = self;
    self.cuisineInput.translatesAutoresizingMaskIntoConstraints = NO;
    self.cuisineInput.layer.borderWidth = .5f;
    self.cuisineInput.layer.borderColor = [[UIColor grayColor] CGColor];
    self.cuisineInput.layer.cornerRadius = 5;//changed from 15
    self.cuisineInput.clipsToBounds = YES;
    [self.cuisineInput setReturnKeyType:UIReturnKeyDone];
    self.cuisineInput.font = [UIFont systemFontOfSize:10];
    
    self.descInput = [[UITextView alloc]init];
    self.descInput.text = descriptionPlaceholder;
    self.descInput.delegate = self;
    self.descInput.textColor = [UIColor grayColor];
    self.descInput.textAlignment = NSTextAlignmentCenter;
    self.descInput.translatesAutoresizingMaskIntoConstraints = NO;
    self.descInput.layer.borderWidth = .5f;
    self.descInput.layer.borderColor = [[UIColor grayColor] CGColor];
    self.descInput.layer.cornerRadius = 5;//changed from 15
    self.descInput.clipsToBounds = YES;

}

- (UIButton *)addServeButton {
    
    if (!_addServeButton) {
        
        _addServeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [[UIImage imageNamed:@"add_user.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_addServeButton addTarget:self action:@selector(incrementServeCount:) forControlEvents:UIControlEventTouchUpInside];
        [_addServeButton setImage:image forState:UIControlStateNormal];
        _addServeButton.tintColor = [UIColor grayColor];
         self.addServeButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _addServeButton;
}

- (UIButton *)reduceServeButton {
    
    if (!_reduceServeButton) {
        
        _reduceServeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [[UIImage imageNamed:@"reduce_serve.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_reduceServeButton addTarget:self action:@selector(decrementServeCount:) forControlEvents:UIControlEventTouchUpInside];
        [_reduceServeButton setImage:image forState:UIControlStateNormal];
        _reduceServeButton.tintColor = [UIColor grayColor];
        self.reduceServeButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _reduceServeButton;
}

- (UIButton *)nextTypeButton {
    
    if (!_nextTypeButton) {
        
        _nextTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [[UIImage imageNamed:@"next.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_nextTypeButton addTarget:self action:@selector(toggleItemType:) forControlEvents:UIControlEventTouchUpInside];
        [_nextTypeButton setImage:image forState:UIControlStateNormal];
        _nextTypeButton.tintColor = [UIColor grayColor];
        self.nextTypeButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _nextTypeButton;
}
- (UIButton *)previousTypeButton {
    
    if (!_previousTypeButton) {
        _previousTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [[UIImage imageNamed:@"precious.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_previousTypeButton addTarget:self action:@selector(toggleItemType:) forControlEvents:UIControlEventTouchUpInside];
        [_previousTypeButton setImage:image forState:UIControlStateNormal];
        _previousTypeButton.tintColor = [UIColor grayColor];
        self.previousTypeButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _previousTypeButton;
}

- (UIView *) progressIndicator {
    
    //NSLog(@"%f",self.addImageBackgroundView.frame.origin.y);
    
    _progressIndicator = [[UIView alloc]init];
    _progressIndicator.translatesAutoresizingMaskIntoConstraints=NO;
    //_progressIndicator = [[UIView alloc]initWithFrame:CGRectMake(35, 45, 100, 40)];
    
//    UIButton *step1Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [step1Button setFrame:CGRectMake(_progressIndicator.frame.origin.x+16,_progressIndicator.frame.origin.y,serveButtonSize, serveButtonSize)];
//    [step1Button setTitle:@"1" forState:UIControlStateNormal];
//    [step1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //[step1Button addTarget:self action:@selector(toggleItemType:) forControlEvents:UIControlEventTouchUpInside];
//    step1Button.layer.borderWidth=1.0f;
//    step1Button.layer.borderColor=[[UIColor blackColor] CGColor];
//    step1Button.layer.backgroundColor = [[UIColor blackColor] CGColor];
//    step1Button.layer.cornerRadius = 10;
//    step1Button.contentEdgeInsets = UIEdgeInsetsMake(buttonInset, 0.0, 0.0, 0.0);
//    
//    UILabel *step1Label = [[UILabel alloc]initWithFrame:CGRectMake(_progressIndicator.frame.origin.x, _progressIndicator.frame.origin.y+serveButtonSize, 60, 20)];
//    [step1Label setText:@"Item Details"];
//    [step1Label setFont:[UIFont systemFontOfSize:InputProgressIndicatorTextSize]];
//    [step1Label setTextColor:[UIColor redColor]];
//    
//    
//    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(_progressIndicator.frame.origin.x+16+serveButtonSize, _progressIndicator.frame.origin.y+serveButtonSize/2, 75, 1.0f)];
//    lineView1.backgroundColor = [UIColor blackColor];
//    
//    
//    UIButton *step2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [step2Button setFrame:CGRectMake(_progressIndicator.frame.origin.x+16+serveButtonSize+lineView1.frame.size.width,_progressIndicator.frame.origin.y,serveButtonSize, serveButtonSize)];
//    [step2Button setTitle:@"2" forState:UIControlStateNormal];
//    [step2Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //[part1Button addTarget:self action:@selector(toggleItemType:) forControlEvents:UIControlEventTouchUpInside];
//    step2Button.layer.borderWidth=1.0f;
//    step2Button.layer.borderColor=[[UIColor blackColor] CGColor];
//    step2Button.layer.backgroundColor = [[UIColor whiteColor] CGColor];
//    step2Button.layer.cornerRadius = 10;
//    step2Button.contentEdgeInsets = UIEdgeInsetsMake(buttonInset, 0.0, 0.0, 0.0);
//    
//    UILabel *step2Label = [[UILabel alloc]initWithFrame:CGRectMake(step1Label.frame.origin.x+lineView1.frame.size.width+8, _progressIndicator.frame.origin.y+serveButtonSize, 80, 20)];
//    [step2Label setText:@"Pickup Information"];
//    [step2Label setFont:[UIFont systemFontOfSize:InputProgressIndicatorTextSize]];
//    
//    
//    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.frame.origin.x+lineView1.frame.size.width+serveButtonSize, _progressIndicator.frame.origin.y+serveButtonSize/2, 75, 1.0f)];
//    lineView2.backgroundColor = [UIColor blackColor];
//    
//    UIButton *step3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [step3Button setFrame:CGRectMake(lineView2.frame.origin.x+lineView2.frame.size.width,_progressIndicator.frame.origin.y,serveButtonSize, serveButtonSize)];
//    [step3Button setTitle:@"3" forState:UIControlStateNormal];
//    [step3Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //[step3Button addTarget:self action:@selector(toggleItemType:) forControlEvents:UIControlEventTouchUpInside];
//    step3Button.layer.borderWidth=1.0f;
//    step3Button.layer.borderColor=[[UIColor blackColor] CGColor];
//    step3Button.layer.backgroundColor = [[UIColor whiteColor] CGColor];
//    step3Button.layer.cornerRadius = 10;
//    step3Button.contentEdgeInsets = UIEdgeInsetsMake(buttonInset, 0.0, 0.0, 0.0);
//    
//    UILabel *step3Label = [[UILabel alloc]initWithFrame:CGRectMake(step2Label.frame.origin.x+lineView2.frame.size.width+26, _progressIndicator.frame.origin.y+serveButtonSize, 80, 20)];
//    [step3Label setText:@"Review/Submit"];
//    [step3Label setFont:[UIFont systemFontOfSize:InputProgressIndicatorTextSize]];
//    
//    [_progressIndicator addSubview:step1Button];
//    [_progressIndicator addSubview:step1Label];
//    [_progressIndicator addSubview:lineView1];
//    [_progressIndicator addSubview:step2Button];
//    [_progressIndicator addSubview:step2Label];
//    [_progressIndicator addSubview:lineView2];
//    [_progressIndicator addSubview:step3Button];
//    [_progressIndicator addSubview:step3Label];
    
    
    return _progressIndicator;
}

-(void)setUpNavigationController {
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.toolbarHidden = NO;
    [self.navigationItem setTitle:@"Item Information"];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:nil
                                  action:nil];
    
    UIBarButtonItem *continueButton = [[UIBarButtonItem alloc]initWithTitle:@"Continue"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(continueButtonPressed:)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self action:@selector(showActionSheet:)];
    
    //[continueButton setTitle:@"Continue"];
    [continueButton setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:12.0],
      NSFontAttributeName, nil]forState:UIControlStateNormal];
    
    [cancelButton setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:12.0],
      NSFontAttributeName, nil]forState:UIControlStateNormal];
    
    cancelButton.tag = cancelButtonTag;// this has tto be assigned
    
    //create an array of buttons
    NSArray *items = [NSArray arrayWithObjects:cancelButton, itemSpace, continueButton, nil];
    //add the buttons to the toolbar
    self.toolbarItems = items;
    
}

-(void)setUpConstraintsNew {
    
    UIView *superview = self.view;
    
//    NSLayoutConstraint *imageViewTopConstraint = [NSLayoutConstraint
//                                                  constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeTop
//                                                  relatedBy:NSLayoutRelationEqual toItem:superview attribute:
//                                                  NSLayoutAttributeTopMargin multiplier:formTopMargin constant:0];
    
    
    
    
    
    
    NSLayoutConstraint *imageViewTopConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                            NSLayoutAttributeTopMargin multiplier:1 constant:0.25*[UIScreen mainScreen].bounds.size.height];
    
    
    NSLayoutConstraint *imageViewLeftConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                   NSLayoutAttributeLeft multiplier:1.0 constant:5.0f];
    
    NSLayoutConstraint *imageViewRightConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeRight
                                                    relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                    NSLayoutAttributeRight multiplier:1.0 constant:-5.0f];
    
    NSLayoutConstraint *imageViewHeightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                     NSLayoutAttributeHeight multiplier:.3 constant:0.0];
    
    NSLayoutConstraint *titleInputLeftConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.titleInput attribute:NSLayoutAttributeLeft
                                                    relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:
                                                    NSLayoutAttributeLeft multiplier:1.0 constant:formLabelToFieldOffset];
    NSLayoutConstraint *titleInputTopConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.titleInput attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual toItem:self.addImageBackgroundView
                                                   attribute:NSLayoutAttributeBottom multiplier:1.0 constant:formFieldToFieldOffsetPercent * [UIScreen mainScreen].bounds.size.height];
    
    NSLayoutConstraint *titleInputRightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.titleInput attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                     NSLayoutAttributeRight multiplier:.95 constant:0];
    NSLayoutConstraint *titleInputHeightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.titleInput attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual toItem:self.servesInput attribute:
                                                     NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *servesInputLeftConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.servesInput attribute:NSLayoutAttributeLeft
                                                    relatedBy:NSLayoutRelationEqual toItem:self.servesLabel attribute:
                                                    NSLayoutAttributeLeft multiplier:1.0 constant:formLabelToFieldOffset];
    NSLayoutConstraint *servesInputTopConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.servesInput attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual toItem:self.titleInput
                                                   attribute:NSLayoutAttributeBottom multiplier:1.0 constant:formFieldToFieldOffsetPercent * [UIScreen mainScreen].bounds.size.height];
    NSLayoutConstraint *servesInputRightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.servesInput attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                     NSLayoutAttributeRight multiplier:formRightMargin constant:0];
    
    NSLayoutConstraint *typeInputLeftConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.typeInput attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual toItem:self.typeLabel attribute:
                                                     NSLayoutAttributeLeft multiplier:1.0 constant:formLabelToFieldOffset];
    NSLayoutConstraint *typeInputTopConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.typeInput attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual toItem:self.servesInput
                                                    attribute:NSLayoutAttributeBottom multiplier:1.0 constant:formFieldToFieldOffsetPercent * [UIScreen mainScreen].bounds.size.height];
    NSLayoutConstraint *typeInputRightConstraint = [NSLayoutConstraint
                                                      constraintWithItem:self.typeInput attribute:NSLayoutAttributeRight
                                                      relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                      NSLayoutAttributeRight multiplier:formRightMargin constant:0];
    NSLayoutConstraint *typeInputHeightConstraint = [NSLayoutConstraint
                                                      constraintWithItem:self.typeInput attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual toItem:self.servesInput attribute:
                                                      NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *descInputLeftConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.descInput attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual toItem:self.descLabel attribute:
                                                   NSLayoutAttributeLeft multiplier:1.0 constant:formLabelToFieldOffset];
    NSLayoutConstraint *descInputTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.descInput attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:self.cuisineInput
                                                  attribute:NSLayoutAttributeBottom multiplier:1.0 constant:formFieldToFieldOffsetPercent* [UIScreen mainScreen].bounds.size.height];
    NSLayoutConstraint *descInputRightConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.descInput attribute:NSLayoutAttributeRight
                                                    relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                    NSLayoutAttributeRight multiplier:formRightMargin constant:0];
    NSLayoutConstraint *descInputHeightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.descInput attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual toItem:self.servesInput attribute:
                                                     NSLayoutAttributeHeight multiplier:3.0 constant:0.0];
    
    
    NSLayoutConstraint *cuisineInputLeftConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.cuisineInput attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual toItem:self.cuisineLabel attribute:
                                                   NSLayoutAttributeLeft multiplier:1.0 constant:formLabelToFieldOffset];
    NSLayoutConstraint *cuisineInputTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.cuisineInput attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:self.typeInput
                                                  attribute:NSLayoutAttributeBottom multiplier:1.0 constant:formFieldToFieldOffsetPercent * [UIScreen mainScreen].bounds.size.height];
    NSLayoutConstraint *cuisineInputRightConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.cuisineInput attribute:NSLayoutAttributeRight
                                                    relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                    NSLayoutAttributeRight multiplier:formRightMargin constant:0];
    NSLayoutConstraint *cuisineInputHeightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.cuisineInput attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual toItem:self.servesInput attribute:
                                                     NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    
    
    NSLayoutConstraint *servesLabelLeftConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.servesLabel attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                     NSLayoutAttributeLeftMargin multiplier:formLeftMargin constant:0];
    
    NSLayoutConstraint *servesLabelTopConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.servesLabel attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual toItem:self.servesInput
                                                    attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *titleLabelLeftConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft
                                                    relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                    NSLayoutAttributeLeftMargin multiplier:formLeftMargin constant:0];
    
    NSLayoutConstraint *titleLabelTopConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual toItem:self.titleInput
                                                   attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *typeLabelLeftConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.typeLabel attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                     NSLayoutAttributeLeftMargin multiplier:formLeftMargin constant:0];
    NSLayoutConstraint *typeLabelTopConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.typeLabel attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual toItem:self.typeInput
                                                    attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *cuisineLabelLeftConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.cuisineLabel attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                   NSLayoutAttributeLeftMargin multiplier:formLeftMargin constant:0];
    NSLayoutConstraint *cuisineLabelTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.cuisineLabel attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:self.cuisineInput
                                                  attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *descLabelLeftConstraint = [NSLayoutConstraint
                                                      constraintWithItem:self.descLabel attribute:NSLayoutAttributeLeft
                                                      relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                      NSLayoutAttributeLeftMargin multiplier:formLeftMargin constant:0];
    NSLayoutConstraint *descLabelTopConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.descLabel attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual toItem:self.descInput
                                                     attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *BottomConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.descInput attribute:NSLayoutAttributeBottom
                                            relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                            NSLayoutAttributeBottomMargin multiplier:formBottomMargin constant:0];
    
    
    [superview addConstraints:@[ titleLabelTopConstraint, titleLabelLeftConstraint]];
    [superview addConstraints:@[ servesLabelTopConstraint, servesLabelLeftConstraint]];
    [superview addConstraints:@[ typeLabelLeftConstraint, typeLabelTopConstraint]];
    [superview addConstraints:@[ cuisineLabelLeftConstraint, cuisineLabelTopConstraint]];
    [superview addConstraints:@[ descLabelLeftConstraint, descLabelTopConstraint]];

    [superview addConstraints:@[ imageViewTopConstraint, imageViewLeftConstraint,imageViewRightConstraint,imageViewHeightConstraint]];
    [superview addConstraints:@[ titleInputRightConstraint, titleInputLeftConstraint, titleInputTopConstraint,titleInputHeightConstraint]];
    [superview addConstraints:@[ servesInputLeftConstraint,servesInputRightConstraint,servesInputTopConstraint,cuisineInputHeightConstraint]];
    [superview addConstraints:@[ typeInputLeftConstraint, typeInputRightConstraint,typeInputTopConstraint,typeInputHeightConstraint]];
    [superview addConstraints:@[ cuisineInputLeftConstraint, cuisineInputRightConstraint,cuisineInputTopConstraint]];
    [superview addConstraints:@[ descInputLeftConstraint, descInputRightConstraint, descInputTopConstraint,descInputHeightConstraint, BottomConstraint]];
    
}

- (IBAction)incrementServeCount:(id)sender {
    self.numberOfServes++;
    self.servesInput.text = [NSString stringWithFormat:@"%ld",self.numberOfServes];
}

- (IBAction)decrementServeCount:(id)sender {
    if(self.numberOfServes!=1)
    {
        self.numberOfServes--;
        self.servesInput.text = [NSString stringWithFormat:@"%ld",self.numberOfServes];
    }
}

- (IBAction)toggleItemType:(id)sender {
    if ([self.typeInput.text isEqualToString:[self.itemTypes objectAtIndex:0]])
    {
        self.typeInput.text = [self.itemTypes objectAtIndex:1];
    }
    else
    {
        self.typeInput.text = [self.itemTypes objectAtIndex:0];
    }
}

- (IBAction)continueButtonPressed:(id)sender {
    
    if(self.pickUpInfoViewController == nil){
        PickUpInfoViewController *secondView = [[PickUpInfoViewController alloc] init];
        self.pickUpInfoViewController= secondView;
    }
    [self.navigationController pushViewController:self.pickUpInfoViewController animated:YES];
}

- (IBAction) didTapButton:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
                                                 init];
    pickerController.delegate = self;
    [self presentModalViewController:pickerController animated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo {
    if(self.pickImageViewController == nil){
        PickImageViewController *secondView = [[PickImageViewController alloc] init];
        self.pickImageViewController= secondView;
    }
    
    self.pickImageViewController.imageRecievedFromPhotoStream = image;
    
    self.pickImageViewController.delegate = self ;
    
    [self.navigationController pushViewController:self.pickImageViewController animated:YES];
    
    
    
    //    self.addImageBackgroundView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)addItemViewController:(PickImageViewController *)controller didFinishEnteringItem:(UIImage *)imageRecieved {
    //NSLog(@"This was returned from PickImageViewController %@",imageRecieved);
    
    self.addImageBackgroundView.image = imageRecieved;
    self.addImageBackgroundView.alpha = 1 ;
    
}

- (void)setUpActionSheets{
    
    addPhotoActionSheetItems = [[NSArray alloc] initWithObjects:@"Remove Image",
                                @"Take Photo",@"Choose Existing", @"Search Web",@"Cancel", nil];
    
    cancelButtonActionSheetItems = [[NSArray alloc] initWithObjects:@"Are you sure you want to delete the listing?",
                                    @"Discard Listing",@"Cancel", nil];
    
    self.addPhotoActionSheet = [[UIActionSheet alloc]
                                initWithTitle:nil
                                delegate:self
                                cancelButtonTitle:[addPhotoActionSheetItems objectAtIndex:4]
                                destructiveButtonTitle:[addPhotoActionSheetItems objectAtIndex:0]
                                otherButtonTitles:[addPhotoActionSheetItems objectAtIndex:1], [addPhotoActionSheetItems objectAtIndex:2], [addPhotoActionSheetItems objectAtIndex:3], nil];
    
    
    self.cancelButtonActionSheet= [[UIActionSheet alloc]initWithTitle:[cancelButtonActionSheetItems objectAtIndex:0] delegate:self cancelButtonTitle:[cancelButtonActionSheetItems objectAtIndex:2] destructiveButtonTitle:[cancelButtonActionSheetItems objectAtIndex:1] otherButtonTitles:nil, nil];
    
}

- (void)showActionSheet:(id)sender {
    
    NSInteger senderTag = [sender tag];
    
    if(senderTag == addPhotoTag)
    {
        [self.addPhotoActionSheet showInView:self.view];
    }
    
    if(senderTag == cancelButtonTag)
    {
        [self.cancelButtonActionSheet showInView:self.view];
    }
    
}

- (void)imageActionSheet:(id)sender{
    [self.addPhotoActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:@"Discard Listing"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([buttonTitle isEqualToString:@"Choose Existing"]) {
        
        [self didTapButton:nil];
    }
    if ([buttonTitle isEqualToString:@"Other Button 2"]) {
        NSLog(@"Other 2 pressed");
    }
    if ([buttonTitle isEqualToString:@"Other Button 3"]) {
        NSLog(@"Other 3 pressed");
    }
    if ([buttonTitle isEqualToString:@"Cancel Button"]) {
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }
}

- (void)setTextFieldProperties:(UITextField *)inputView {
    
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    inputView.layer.borderWidth = .5f;
    inputView.layer.borderColor = [[UIColor grayColor] CGColor];
    inputView.layer.cornerRadius = 5;//changed from 15
    inputView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //[self.descInput becomeFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@""])
    {
        textField.text = titlePlaceholder;
        textField.textColor = [UIColor grayColor];
    }
    
    /*
    
     if ([textView.text isEqualToString:@""]) {
     
     if(textView.tag == 0) {
     textView.text = titlePlaceholder;
     }
     
     if(textView.tag == 1)
     {
     textView.text = descriptionPlaceholder;
     }
     
     if(textView.tag == 2)
     {
     textView.text = cuisinePlaceholder;
     }
     
     textView.textColor = [UIColor lightGrayColor];
     
     }
     [textView resignFirstResponder];
    
*/
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:titlePlaceholder])
    {
        textField.text = @"";
        textField.textColor = [UIColor blackColor];
    }
    
//    if ([textView.text isEqualToString:titlePlaceholder])
//    {
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor];
//    }
//    
//    if ([textView.text isEqualToString:descriptionPlaceholder])
//    {
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor];
//    }
//    
//    if ([textView.text isEqualToString:cuisinePlaceholder])
//    {
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor];
//    }
//    
//    [textView becomeFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // dismiss keyboard through `resignFirstResponder`
    [self.titleInput resignFirstResponder];
    [self.descInput resignFirstResponder];
    [self.cuisineInput resignFirstResponder];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
