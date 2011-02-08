//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Sergei on 31.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
	IBOutlet UILabel *display;
	IBOutlet UILabel *errDisplay;
	IBOutlet UILabel *memDisplay;
	IBOutlet UISwitch *radiansSwitch;
	CalculatorBrain *brain;
	BOOL userIsInTheMiddleOfTypingANumber;
	BOOL dotIsPressed;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)dotPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)backspacePressed:(UIButton *)sender;
- (IBAction)radiansSwitchToggled:(UISwitch *)sender;

@end

