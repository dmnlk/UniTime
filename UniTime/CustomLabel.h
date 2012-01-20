//
//  CustomLabel.h
//  UniTime
//
//  Created by dmnlk on 11/12/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomLabel : UILabel {
    NSString *infolesson;
    NSString *inforoom;
    NSString *infoteacher;
    int tag;
}
@property (nonatomic,copy) NSString *infolesson;
@property (nonatomic,copy) NSString *inforoom;
@property (nonatomic,copy) NSString *infoteacher;
@property (nonatomic,assign)int tag;
@end
