//
//  ExampleCLibrary.m
//  ExampleCLibrary
//
//  Created by ceciliah on 2/5/31 H.
//  Copyright © 31 Heisei Humlan. All rights reserved.
//

#include "ExampleCLibrary.h"
#include <time.h>
#include <stdio.h>

#pragma mark - Global variable

char * globalChar = "c";

#pragma mark - Global function

char * randomString(int size) {
    static char const charBase[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    int count = strlen(charBase);
    char * randChar;
    srand((unsigned int) time(0));
    randChar = (char *)malloc(sizeof(char) * size + 1);
    for (int i = 0; i < size; i++) {
        int num = rand()%count;
        char generated = charBase[num];
        randChar[i] = generated;
    }
    randChar[size] = 0;
    return randChar;
}

#pragma mark - Global struct

const char *DayInWeek[7] = {"月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"};

void print_nationlity_country(struct Nationality * const nationality) {
    printf("nationality country is %s \n", nationality->country);
}

#pragma mark - Global enum

enum 曜日 currentDayOfWeek() {
    time_t t = time(NULL);
    struct tm *tmp = localtime(&t);
    printf("tm %i \n", tmp->tm_wday);
    return tmp->tm_wday;
}

#pragma mark - Functional pointer

int functionPointer(int startValue, int (*getNextValue)(int)) {
    printf("next value is %d \n", getNextValue(startValue));
    return getNextValue(startValue);
}
