//
//  MyView.h
//  TabNavTableTest
//
//  Created by dmnlk on 11/11/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol modalViewDelegate <NSObject>

-(void)modalViewWillClose;

@end
@interface MyView : UIViewController {
    id delegate;
    UIButton *button;
}

@property (nonatomic,retain)id delegate;
@end
