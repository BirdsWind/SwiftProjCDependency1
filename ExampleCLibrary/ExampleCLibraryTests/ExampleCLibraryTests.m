//
//  ExampleCLibraryTests.m
//  ExampleCLibraryTests
//
//  Created by ceciliah on 2/5/31 H.
//  Copyright © 31 Heisei Humlan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ExampleCLibrary/ExampleCLibrary.h>
#import <string.h>


@interface ExampleCLibraryTests : XCTestCase

@end

@implementation ExampleCLibraryTests

- (void)testFunction {
    int length = 10;
    char * result = randomString(length);
   // NSString *strRes = [NSString stringWithCString:result encoding:(NSUTF8StringEncoding)];
    NSString *strRes = [[NSString alloc] initWithBytesNoCopy:result length:strlen(result) encoding:NSUTF8StringEncoding freeWhenDone:YES];
    NSLog(@"result is %s", result);
    NSLog(@"string result is %@", strRes);
   // free(result);
}

- (void)testMacro {
    int result = max(5, 6);
    XCTAssertEqual(result, 6);
}

- (void)testStruct {
    int testNumber = 123;
    char * testString = "Sweden";
    //size of the struct and a terminator
    // need to type def struct
    struct Nationality  * nationality = malloc(sizeof(struct Nationality) + sizeof(char) * strlen(testString) + 1);
    nationality->identifier = testNumber;
    //copy sets the last input to 0 
    strcpy(nationality->country, testString);
    XCTAssertEqual(nationality->identifier, testNumber);

    XCTAssertEqual(strcmp(nationality->country, testString), 0);
    free(nationality);
}


- (void)testGlobal {
    XCTAssertEqual(globalNumber, 6);
    globalNumber = 7;
    XCTAssertEqual(globalNumber, 7);
}

- (void)testEnum {
    enum Week day = 木曜日;
    const char *dayString = DayInWeek[day];
    NSString *dayInWeek = [NSString stringWithCString:dayString encoding:NSUTF8StringEncoding];
    XCTAssertEqualObjects(dayInWeek, @"木曜日");
}

// c function to be used in function pointer
int getNextVal(int val) {
    return val + 1;
}

- (void)testFunctionPointer {
    XCTAssertEqual(functionPointer(5, getNextVal), 6);
}


@end
