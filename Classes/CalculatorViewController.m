//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Sergei on 31.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

- (CalculatorBrain *)brain
{
	if (!brain) brain = [[CalculatorBrain alloc] init];
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [[sender titleLabel] text];
	
	if (userIsInTheMiddleOfTypingANumber) {
		[display setText:[[display text] stringByAppendingString:digit]];
	} else {
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

- (IBAction)dotPressed:(UIButton *)sender
{
	if (!dotIsPressed) {
		if (userIsInTheMiddleOfTypingANumber) {
			[display setText:[[display text] stringByAppendingString:@"."]];
		} else {
			[display setText:@"0."];
			 userIsInTheMiddleOfTypingANumber = YES;
		}
		dotIsPressed = YES;
	}
}

- (IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber) {
		[[self brain] setOperand:[[display text] doubleValue]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	dotIsPressed = NO;
	NSString *operation = [[sender titleLabel] text];
	double result = [[self brain] performOperation:operation];
	[display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
