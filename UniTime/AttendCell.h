//
//  AttendCell.h
//  Uninavi_attend
//
//  Created by dmnlk on 11/11/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendCell : UITableViewCell {

    UILabel *SubjectLabel;
    UILabel *AttendLabel;
    UILabel *KessekiLabel;
    UILabel *ChikokuLabel;
    UILabel *KyukoLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *SubjectLabel;
@property (nonatomic, retain) IBOutlet UILabel *AttendLabel;
@property (nonatomic, retain) IBOutlet UILabel *KessekiLabel;
@property (nonatomic, retain) IBOutlet UILabel *ChikokuLabel;
@property (nonatomic, retain) IBOutlet UILabel *KyukoLabel;


@end
