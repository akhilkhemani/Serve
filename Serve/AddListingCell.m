//
//  AddListingCell.m
//  Serve
//
//  Created by Akhil Khemani on 5/17/15.
//  Copyright (c) 2015 Akhil Khemani. All rights reserved.
//

#import "AddListingCell.h"

@implementation AddListingCell

@synthesize descriptionLabel = _descriptionLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 300, 30)];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:22.0f];
        self.descriptionLabel.text = @"+";
        
        [self addSubview:self.descriptionLabel];
    }
    return self;
    
//    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
//        //self.textLabel.font = [UIFont ];
//        self.textLabel.textColor = [UIColor blackColor];
//        
//        [self.textLabel setFrame:CGRectMake(100, 100, 30, 30)];
//        //self.textLabel.frame = CGRectMake(100, 100, 30, 30);
//        //self.detailTextLabel.font = [UIFont ws_fontWithKey:WSFontHelveticaNeue withSize:12];
//        self.detailTextLabel.textColor = [UIColor grayColor];
//    }
//    
//    return self;
//    
    
    
}

@end
