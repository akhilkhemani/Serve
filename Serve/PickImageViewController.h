//
//  ImageViewController.h
//  Serve
//
//  Created by Akhil Khemani on 5/17/15.
//  Copyright (c) 2015 Akhil Khemani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickImageViewController : UIViewController<UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImage *imageRecievedFromPhotoStream;

@end
