//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Sergei on 31.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property (readonly) CalculatorBrain *brain;
@end


@implementation CalculatorViewController

- (CalculatorBrain *)brain
{
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
	}
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
	errDisplay.text = self.brain.errMsg;
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
	errDisplay.text = self.brain.errMsg;
}

- (IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber) {
		self.brain.operand = display.text.doubleValue;
		userIsInTheMiddleOfTypingANumber = NO;
	}
	dotIsPressed = NO;
	NSString *operation = sender.titleLabel.text;
	double result = [self.brain performOperation:operation];
	if (self.brain.errMsg) {
		errDisplay.text = self.brain.errMsg;
		self.brain.errMsg = nil;
	} else {
		errDisplay.text = self.brain.errMsg;
		[display setText:[NSString stringWithFormat:@"%g", result]];
	}
	memDisplay.text = [NSString stringWithFormat:@"%g", self.brain.memoryCell];
}

- (IBAction)backspacePressed:(UIButton *)sender
{
	NSUInteger displayStringLength = display.text.length;
	if (displayStringLength > 1) {
		display.text = [display.text substringToIndex:(displayStringLength - 1)];
	} else {
		display.text = @"0";
		userIsInTheMiddleOfTypingANumber = NO;
	}
}

- (void)dealloc
{
	[brain release];
	[super dealloc];
}
@end
