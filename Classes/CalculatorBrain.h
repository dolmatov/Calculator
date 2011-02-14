//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Sergei on 31.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VARIABLE_PREFIX @"%"

@interface CalculatorBrain : NSObject {
@private
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
@private
	double memoryCell;
@private
	NSString *errMsg;
@private
	NSMutableArray *internalExpression;
}

@property double operand;
@property double memoryCell;
@property (assign) NSString *errMsg;
- (void)setVariableAsOperand:(NSString *)variableName;
- (double)performOperation:(NSString *)operation;

@property (readonly) id expression;

+ (double)evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary *)variables;
+ (NSSet *)variablesInExpression:(id)anExpression;
+ (NSString *)descriptionOfExpression:(id)anExpression;
+ (BOOL)isVariable:(NSString *)aValue;
+ (NSDictionary *)tempVariables;
@end
