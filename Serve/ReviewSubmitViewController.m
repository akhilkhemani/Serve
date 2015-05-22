//
//  ReviewSubmitViewController.m
//  Serve Akhil
//
//  Created by Akhil Khemani on 5/14/15.
//  Copyright (c) 2015 Akhil Khemani. All rights reserved.
//

#import "ReviewSubmitViewController.h"

const CGFloat reviewProgressButtonSize = 19.0f;
const CGFloat reviewProgressButtonY = 365.0f;
const CGFloat reviewProgressButtonX = 80.0f;
const CGFloat reviewProgressButtonInset = -2.0f;
const CGFloat reviewProgressIndicatorTextSize = 9.0f;


//const CGFloat imageViewHeight = 160.0f;
//const CGFloat formRightMargin = -15.0f;
//const CGFloat formLeftMargin = 15.0f;
//const CGFloat formTopMargin = 160.0f;
//const CGFloat formItemHeight = 30.0f;
//const CGFloat formItemToItemOffset = 20.0f;
//const CGFloat formLabelToFieldOffset = 10.0f;
//const CGFloat formFieldHeight = 20.0f;
//static NSString * const titlePlaceholder = @"Title";

static NSArray *deleteButtonActionSheetItems = nil;
const CGFloat reviewDeleteButtonTag = 1;

@interface ReviewSubmitViewController ()

@property (nonatomic, strong) UIView *progressIndicator;
@property (nonatomic, strong) UIActionSheet *deleteButtonActionSheet;


//starting fresh
@property (nonatomic, strong) UIImageView *addImageBackgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *titleInput;
@property (nonatomic, strong) UIButton *addPhotoActionSheetButton;
@property (nonatomic, strong) UITextView *descriptionInput;
@property (nonatomic, readwrite,assign) NSInteger numberOfServes;
@property (nonatomic, strong) UITextField *servesInput;
@property (nonatomic, strong) UITextField *typeInput;
@property (nonatomic, strong) UITextField *cuisineInput;
@property (nonatomic, retain) NSArray* itemTypes;

- (IBAction)submitButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (void)showActionSheet:(id)sender;

@end

@implementation ReviewSubmitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //[self setUpActionSheets];
    [self setUpNavigationController];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //[self.view addSubview:self.progressIndicator];

    
  /*
    //ADD PHOTO BIG BACKGROUND IMAGE
    self.addImageBackgroundView = [[UIImageView alloc]init];
    self.addImageBackgroundView.image = [UIImage imageNamed:@"food1-gray.jpg"];
    //self.addImageBackgroundView.alpha = 0.6f;
    self.addImageBackgroundView.layer.borderColor = [UIColor blackColor].CGColor;
    self.addImageBackgroundView.layer.borderWidth = 0.5f;
    self.addImageBackgroundView.layer.cornerRadius = 10;
    self.addImageBackgroundView.tag = 0;
    [self.addImageBackgroundView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
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
    //addPhotoActionSheetButton.tag = addPhotoTag;
    
    
    self.titleLabel  = [UILabel new];
    [self.titleLabel setText:@"*Title:"];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
   
    self.titleInput.tag = 1;
    self.titleInput = [[UITextField alloc]init];
    self.titleInput.delegate = self;
    self.titleInput.textColor = [UIColor grayColor];
    self.titleInput.font = [UIFont systemFontOfSize:10];
    self.titleInput.textAlignment = NSTextAlignmentCenter;
    [self.titleInput setReturnKeyType:UIReturnKeyDone];
    self.titleInput.text = titlePlaceholder;
    [self setTextFieldProperties:self.titleInput];
    
    
    
    
    
    

    
    self.descriptionInput = [[UITextView alloc]init];
    self.descriptionInput.backgroundColor = [UIColor yellowColor];
    self.descriptionInput.delegate = self;
    self.descriptionInput.textColor = [UIColor blackColor];
    self.descriptionInput.textAlignment = NSTextAlignmentCenter;
    self.descriptionInput.tag = 0;
    [self.descriptionInput setScrollEnabled:YES];
    self.descriptionInput.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionInput.layer.borderWidth = .5f;
    self.descriptionInput.layer.borderColor = [[UIColor grayColor] CGColor];
    self.descriptionInput.layer.cornerRadius = 5;//changed from 15
    self.descriptionInput.clipsToBounds = YES;
    
    [self.view addSubview:self.addImageBackgroundView];
    [self.view addSubview:self.addPhotoActionSheetButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleInput];
    [self.view addSubview:self.descriptionInput];
    
    [self setUpConstraints];
   
   */
    }




//-(void)setUpConstraints
//{
//
//    UIView *superview = self.view;
//    
//    
//    NSLayoutConstraint *imageViewTopConstraint = [NSLayoutConstraint
//                                                   constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeTop
//                                                   relatedBy:NSLayoutRelationEqual toItem:superview attribute:
//                                                   NSLayoutAttributeTop multiplier:1.0 constant:formTopMargin];
//    
//    NSLayoutConstraint *imageViewLeftConstraint = [NSLayoutConstraint
//                                                   constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeLeft
//                                                   relatedBy:NSLayoutRelationEqual toItem:superview attribute:
//                                                   NSLayoutAttributeLeft multiplier:1.0 constant:5.0f];
//    
//    NSLayoutConstraint *imageViewRightConstraint = [NSLayoutConstraint
//                                                  constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeRight
//                                                  relatedBy:NSLayoutRelationEqual toItem:superview attribute:
//                                                  NSLayoutAttributeRight multiplier:1.0 constant:-5.0f];
//    
//    NSLayoutConstraint *imageViewHeightConstraint = [NSLayoutConstraint
//                                                     constraintWithItem:self.addImageBackgroundView attribute:NSLayoutAttributeBottom
//                                                     relatedBy:NSLayoutRelationEqual toItem:self.addImageBackgroundView attribute:
//                                                     NSLayoutAttributeTop multiplier:1.0 constant:imageViewHeight];
//    
//    NSLayoutConstraint *addPhotoButtonCenterXConstraint = [NSLayoutConstraint
//                                                     constraintWithItem:self.addPhotoActionSheetButton attribute:NSLayoutAttributeCenterX
//                                                     relatedBy:NSLayoutRelationEqual toItem:self.addImageBackgroundView attribute:
//                                                     NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    
//    NSLayoutConstraint *addPhotoButtonCenterYConstraint = [NSLayoutConstraint
//                                                    constraintWithItem:self.addPhotoActionSheetButton attribute:NSLayoutAttributeCenterY
//                                                    relatedBy:NSLayoutRelationEqual toItem:self.addImageBackgroundView attribute:
//                                                    NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];
//    
//    
//    //for titleLabel
//    NSLayoutConstraint *titleLabelLeftConstraint = [NSLayoutConstraint
//                                                    constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft
//                                                    relatedBy:NSLayoutRelationEqual toItem:superview attribute:
//                                                    NSLayoutAttributeLeft multiplier:1.0 constant:formLeftMargin];
//    
//    NSLayoutConstraint *titleLabelTopConstraint = [NSLayoutConstraint
//                                                   constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop
//                                                   relatedBy:NSLayoutRelationEqual toItem:self.addImageBackgroundView
//                                                   attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0f];
//    
//    
//    NSLayoutConstraint *titleInputLeftConstraint = [NSLayoutConstraint
//                                                    constraintWithItem:self.titleInput attribute:NSLayoutAttributeLeft
//                                                    relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:
//                                                    NSLayoutAttributeRight multiplier:1.0 constant:formLabelToFieldOffset];
//    
//    NSLayoutConstraint *titleInputTopConstraint = [NSLayoutConstraint
//                                                   constraintWithItem:self.titleInput attribute:NSLayoutAttributeTop
//                                                   relatedBy:NSLayoutRelationEqual toItem:self.addImageBackgroundView
//                                                   attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0f];
//    
//    NSLayoutConstraint *titleInputRightConstraint = [NSLayoutConstraint
//                                                     constraintWithItem:self.titleInput attribute:NSLayoutAttributeRight
//                                                     relatedBy:NSLayoutRelationEqual toItem:superview attribute:
//                                                     NSLayoutAttributeRight multiplier:1.0 constant:formRightMargin];
//    
//    
//    NSLayoutConstraint *titleInputHeightConstraint = [NSLayoutConstraint
//                                                     constraintWithItem:self.titleInput attribute:NSLayoutAttributeBottom
//                                                     relatedBy:NSLayoutRelationEqual toItem:self.titleInput attribute:
//                                                     NSLayoutAttributeTop multiplier:1.0 constant:formItemHeight];
//    
//    
//    
//    
//    
//    
//    [superview addConstraints:@[addPhotoButtonCenterXConstraint,addPhotoButtonCenterYConstraint]];
//    [superview addConstraints:@[ imageViewTopConstraint, imageViewLeftConstraint,
//                                 imageViewRightConstraint,imageViewHeightConstraint]];
//    
//    [superview addConstraints:@[ titleLabelTopConstraint, titleLabelLeftConstraint]];
//    [superview addConstraints:@[ titleInputRightConstraint, titleInputLeftConstraint,
//                                 titleInputTopConstraint,titleInputHeightConstraint]];
//
//    
//
//    
//    NSLayoutConstraint *descriptionInputTopConstraint = [NSLayoutConstraint
//                                                         constraintWithItem:self.descriptionInput attribute:NSLayoutAttributeTop
//                                                         relatedBy:NSLayoutRelationEqual toItem:self.titleInput
//                                                         attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5];
//    
//    NSLayoutConstraint *descriptionInputLeftConstraint = [NSLayoutConstraint
//                                                          constraintWithItem:self.descriptionInput attribute:NSLayoutAttributeLeft
//                                                          relatedBy:NSLayoutRelationEqual toItem:superview attribute:
//                                                          NSLayoutAttributeLeft multiplier:1.0 constant:50.0f];
//    
//    NSLayoutConstraint *descriptionInputRightConstraint = [NSLayoutConstraint
//                                                           constraintWithItem:self.descriptionInput attribute:NSLayoutAttributeRight
//                                                           relatedBy:NSLayoutRelationEqual toItem:superview attribute:
//                                                           NSLayoutAttributeRight multiplier:1.0 constant:-50.0f];
//    
//    
//    NSLayoutConstraint *descriptionInputHeightConstraint = [NSLayoutConstraint
//                                                            constraintWithItem:self.descriptionInput attribute:NSLayoutAttributeBottom
//                                                            relatedBy:NSLayoutRelationEqual toItem:self.descriptionInput
//                                                            attribute:NSLayoutAttributeTop multiplier:1.0 constant:40];
//    
////    [superview addConstraints:@[descriptionInputLeftConstraint, descriptionInputRightConstraint,
////                                descriptionInputTopConstraint, descriptionInputHeightConstraint]];
//
//    
//}

- (UIView *)progressIndicator {
    
    _progressIndicator = [[UIView alloc]initWithFrame:CGRectMake(35, 45, 100, 40)];
    
    UIButton *step1Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [step1Button setFrame:CGRectMake(_progressIndicator.frame.origin.x+16,_progressIndicator.frame.origin.y,reviewProgressButtonSize, reviewProgressButtonSize)];
    [step1Button setTitle:@"1" forState:UIControlStateNormal];
    [step1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[step1Button addTarget:self action:@selector(toggleItemType:) forControlEvents:UIControlEventTouchUpInside];
    step1Button.layer.borderWidth=1.0f;
    step1Button.layer.borderColor=[[UIColor blackColor] CGColor];
    step1Button.layer.backgroundColor = [[UIColor blackColor] CGColor];
    step1Button.layer.cornerRadius = 10;
    step1Button.contentEdgeInsets = UIEdgeInsetsMake(reviewProgressButtonInset, 0.0, 0.0, 0.0);
    
    UILabel *step1Label = [[UILabel alloc]initWithFrame:CGRectMake(_progressIndicator.frame.origin.x, _progressIndicator.frame.origin.y+reviewProgressButtonSize, 60, 20)];
    [step1Label setText:@"Item Details"];
    [step1Label setFont:[UIFont systemFontOfSize:reviewProgressIndicatorTextSize]];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(_progressIndicator.frame.origin.x+16+reviewProgressButtonSize, _progressIndicator.frame.origin.y+reviewProgressButtonSize/2, 75, 1.0f)];
    lineView1.backgroundColor = [UIColor blackColor];
    
    UIButton *step2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [step2Button setFrame:CGRectMake(_progressIndicator.frame.origin.x+16+reviewProgressButtonSize+lineView1.frame.size.width,_progressIndicator.frame.origin.y,reviewProgressButtonSize, reviewProgressButtonSize)];
    [step2Button setTitle:@"2" forState:UIControlStateNormal];
    [step2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[part1Button addTarget:self action:@selector(toggleItemType:) forControlEvents:UIControlEventTouchUpInside];
    step2Button.layer.borderWidth=1.0f;
    step2Button.layer.borderColor=[[UIColor blackColor] CGColor];
    step2Button.layer.backgroundColor = [[UIColor blackColor] CGColor];
    step2Button.layer.cornerRadius = 10;
    step2Button.contentEdgeInsets = UIEdgeInsetsMake(reviewProgressButtonInset, 0.0, 0.0, 0.0);
    
    UILabel *step2Label = [[UILabel alloc]initWithFrame:CGRectMake(step1Label.frame.origin.x+lineView1.frame.size.width+8, _progressIndicator.frame.origin.y+reviewProgressButtonSize, 80, 20)];
    [step2Label setText:@"Pickup Information"];
    [step2Label setFont:[UIFont systemFontOfSize:reviewProgressIndicatorTextSize]];
   
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.frame.origin.x+lineView1.frame.size.width+reviewProgressButtonSize, _progressIndicator.frame.origin.y+reviewProgressButtonSize/2, 75, 2.0f)];
    lineView2.backgroundColor = [UIColor blackColor];
    
    
    UIButton *step3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [step3Button setFrame:CGRectMake(lineView2.frame.origin.x+lineView2.frame.size.width,_progressIndicator.frame.origin.y,reviewProgressButtonSize, reviewProgressButtonSize)];
    [step3Button setTitle:@"3" forState:UIControlStateNormal];
    [step3Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[step3Button addTarget:self action:@selector(toggleItemType:) forControlEvents:UIControlEventTouchUpInside];
    step3Button.layer.borderWidth=1.0f;
    step3Button.layer.borderColor=[[UIColor blackColor] CGColor];
    step3Button.layer.backgroundColor = [[UIColor blackColor] CGColor];
    step3Button.layer.cornerRadius = 10;
    step3Button.contentEdgeInsets = UIEdgeInsetsMake(reviewProgressButtonInset, 0.0, 0.0, 0.0);
    
    UILabel *step3Label = [[UILabel alloc]initWithFrame:CGRectMake(step2Label.frame.origin.x+lineView2.frame.size.width+26, _progressIndicator.frame.origin.y+reviewProgressButtonSize, 80, 20)];
    [step3Label setText:@"Review/Submit"];
    [step3Label setFont:[UIFont systemFontOfSize:reviewProgressIndicatorTextSize]];
    [step3Label setTextColor:[UIColor redColor]];
    
    [_progressIndicator addSubview:step1Button];
    [_progressIndicator addSubview:step1Label];
    [_progressIndicator addSubview:lineView1];
    [_progressIndicator addSubview:step2Button];
    [_progressIndicator addSubview:step2Label];
    [_progressIndicator addSubview:lineView2];
    [_progressIndicator addSubview:step3Button];
    [_progressIndicator addSubview:step3Label];
    
    return _progressIndicator;
}


-(void) setUpNavigationController
{
    [self.navigationItem setTitle:@"Review & Submit"];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.toolbarHidden = NO;
    
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:nil
                                  action:nil];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Back"
                                   style: UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(backButtonPressed:)];
    
    
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Submit"
                                     style: UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(submitButtonPressed:)];
    
    //trash button
    UIImage *trashImage = [UIImage imageNamed:@"trash.png"];
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:trashImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, trashImage.size.width, trashImage.size.height)];
    button.tag = reviewDeleteButtonTag;
    UIBarButtonItem *trashButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    /////
    
    ///setting color of back and continue buttons to black
    [submitButton setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:12.0],
      NSFontAttributeName, nil]forState:UIControlStateNormal];
    
    [backButton setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:12.0],
      NSFontAttributeName, nil]forState:UIControlStateNormal];
    ////////////////////////////////////////////////////////////
    
    NSArray *items = [NSArray arrayWithObjects:backButton, itemSpace, trashButton, itemSpace, submitButton, nil];
    self.toolbarItems = items;
    
}

- (void)setTextFieldProperties:(UITextField *)inputView {
    
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    inputView.layer.borderWidth = .5f;
    inputView.layer.borderColor = [[UIColor grayColor] CGColor];
    inputView.layer.cornerRadius = 5;//changed from 15
    inputView.clipsToBounds = YES;
}



- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonPressed:(id)sender
{
    NSLog(@"Trying to submit");
}


- (void) setUpActionSheets{
    
    deleteButtonActionSheetItems = [[NSArray alloc] initWithObjects:@"Are you sure you want to delete the listing?",
                                    @"Discard Listing",@"Cancel", nil];
    
    self.deleteButtonActionSheet= [[UIActionSheet alloc]initWithTitle:[deleteButtonActionSheetItems objectAtIndex:0] delegate:self cancelButtonTitle:[deleteButtonActionSheetItems objectAtIndex:2] destructiveButtonTitle:[deleteButtonActionSheetItems objectAtIndex:1] otherButtonTitles:nil, nil];
    
}

- (void) showActionSheet:(id)sender {
    NSInteger senderTag = [sender tag];
    
    if(senderTag == reviewDeleteButtonTag)
    {
        [self.deleteButtonActionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:@"Discard Listing"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if ([buttonTitle isEqualToString:@"Other Button 1"]) {
        NSLog(@"Other 1 pressed");
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
