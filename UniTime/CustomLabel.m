//
//  CustomLabel.m
//  UniTime
//
//  Created by dmnlk on 11/12/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomLabel.h"


@implementation CustomLabel
@synthesize infolesson;
@synthesize inforoom;
@synthesize infoteacher;
@synthesize tag;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
    CGRect menuRect;
    if (self.tag ==1) {
        menuRect = CGRectMake(0, 35, 10, 10);
    }else if(self.tag == 2){
        menuRect = CGRectMake(0,20, 10, 10);
    }
    else{
        menuRect = CGRectZero;
    }
    
    
    if ([self.infolesson length]>0) {
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:menuRect inView:self];
        menu.arrowDirection = UIMenuControllerArrowDefault;
        NSString *str = [NSString stringWithFormat:@"%@ \n%@\n%@",self.infolesson,self.inforoom,self.infoteacher];
        
        UIMenuItem *item = [[[UIMenuItem alloc] initWithTitle:str action:@selector(hoge:)] autorelease];
        
        menu.menuItems = [NSArray arrayWithObjects:item, nil];
        [menu setMenuVisible:YES animated:YES];
    }
	
}
- (void)hoge:(id)sender {
	
}
@end
