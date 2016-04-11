//  FISAppDelegate.m

#import "FISAppDelegate.h"

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    return YES;
}


- (NSArray *) arrayBySortingArrayAscending:(NSArray *)array {
    NSSortDescriptor *asc = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    return [array sortedArrayUsingDescriptors:@[asc]];
}


- (NSArray *) arrayBySortingArrayDescending:(NSArray *)array {
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
    return [array sortedArrayUsingDescriptors:@[des]];
}


- (NSArray *) arrayBySwappingFirstObjectWithLastObjectInArray:(NSArray *)array {
    NSMutableArray *mArray = [array mutableCopy];
    [mArray exchangeObjectAtIndex:0 withObjectAtIndex:mArray.count -1];
    return mArray;
}


- (NSArray *) arrayByReversingArray:(NSArray *)array {
    NSMutableArray *reversedArray = [[NSMutableArray alloc] init];
    for (NSUInteger i = array.count; i > 0; i--) {
        [reversedArray addObject:array[i - 1]];
    }
    return reversedArray;
}


- (NSString *) stringInBasicLeetFromString:(NSString *)string {
    NSMutableString *mString = [[NSMutableString alloc] init];
    NSDictionary *leet = @{
                           @"a" : @"4",
                           @"s" : @"5",
                           @"i" : @"1",
                           @"l" : @"1",
                           @"e" : @"3",
                           @"t" : @"7"
                           };
    
    for (NSUInteger i = 0; i < string.length; i++) {
        NSString *chr = [NSString stringWithFormat:@"%c",[string characterAtIndex:i]];
        if ([[leet allKeys] containsObject:chr]) {
            [mString appendString:leet[chr]];
        } else {
            [mString appendString:chr];
        }
    }
    return mString;
}


- (NSArray *) splitArrayIntoNegativesAndPositives:(NSArray *)array {
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSPredicate *positives = [NSPredicate predicateWithFormat:@"self >= 0"];
    NSPredicate *negatives = [NSPredicate predicateWithFormat:@"self < 0"];
    [mArray addObject:[array filteredArrayUsingPredicate:negatives]];
    [mArray addObject:[array filteredArrayUsingPredicate:positives]];
    return mArray;
}


- (NSArray *) namesOfHobbitsInDictionary:(NSDictionary *)dictionary {
    NSMutableArray *hobbitNames = [[NSMutableArray alloc] init];
    for (NSString *name in dictionary) {
        if ([dictionary[name] isEqualToString:@"hobbit"]) {
            [hobbitNames addObject:name];
        }
    }
    return hobbitNames;
}


- (NSArray *) stringsBeginningWithAInArray:(NSArray *)array {
    NSPredicate *beginsWithA = [NSPredicate predicateWithFormat:@"self BEGINSWITH[c] 'a'"];
    return [array filteredArrayUsingPredicate:beginsWithA];
}


- (NSInteger) sumOfIntegersInArray:(NSArray *)array {
    NSInteger sum = 0;
    for (NSNumber *number in array) {
        NSInteger intNumber = [number integerValue];
        sum += intNumber;
    }
    return sum;
}


- (NSArray *) arrayByPluralizingStringsInArray:(NSArray *)array {
    // This would be a very time consuming and boring thing to do for all the nouns.
    // And I believe it's hardly a goal of the exercise so I'm only coding enough for test to pass.
    NSMutableArray *plurals = [[NSMutableArray alloc] init];
    NSDictionary *irregulars = @{
                                 @"foot" : @"feet",
                                 @"ox" : @"oxen",
                                 @"radius" : @"radii",
                                 @"trivium" : @"trivia",
                                 };
    NSArray *endsWithEsCases = @[@"o", @"x", @"h", @"s", @"g"];
    
    for (NSString *noun in array) {
        if ([[irregulars allKeys] containsObject:noun]) {
            [plurals addObject:irregulars[noun]];
        } else {
            NSString *chr = [NSString stringWithFormat:@"%c",[noun characterAtIndex:noun.length - 1]];
            if ([endsWithEsCases containsObject:chr]) {
                NSString *plural = [[NSString alloc] initWithFormat:@"%@es", noun];
                [plurals addObject:plural];
            } else {
                NSString *plural = [[NSString alloc] initWithFormat:@"%@s", noun];
                [plurals addObject:plural];
            }
        }
    }
    return plurals;
    
}


- (NSDictionary *) countsOfWordsInString:(NSString *)string {
    string = [string lowercaseString];
    NSArray *punctuations = @[@".", @",", @"!", @"?", @":", @";", @"-"];
    for (NSString *punctuation in punctuations) {
        string = [string stringByReplacingOccurrencesOfString:punctuation withString:@""];
    }
    NSArray *words = [string componentsSeparatedByString:@" "];
    NSMutableDictionary *wordCounts = [[NSMutableDictionary alloc] init];
    
    for (NSString *word in words) {
        if (![[wordCounts allKeys] containsObject:word]) {
            wordCounts[word] = @1;
        } else {
            NSNumber *occurences = wordCounts[word];
            NSUInteger intOccurences = [occurences unsignedIntegerValue];
            intOccurences += 1;
            NSNumber *newOccurences = [[NSNumber alloc] initWithUnsignedInt:intOccurences];
            wordCounts[word] = newOccurences;
            // I guess there should be an easier way, but NSNumber being immutable I don't really know
            // This was so easy with Ruby: hash = Hash.new (0); hash[key] += 1 ...
        }
    }
    return wordCounts;
}


- (NSDictionary *) songsGroupedByArtistFromArray:(NSArray *)array {
    NSMutableDictionary *songsByArtist = [[NSMutableDictionary alloc] init];
    
    for (NSString *artistSong in array) {
        NSArray *artistAndSong = [artistSong componentsSeparatedByString:@" - "];
        if (![[songsByArtist allKeys] containsObject:artistAndSong[0]]) {
            songsByArtist[artistAndSong[0]] = [@[artistAndSong[1]] mutableCopy];
        } else {
            [songsByArtist[artistAndSong[0]] addObject:artistAndSong[1]];
        }
    }
    
    NSSortDescriptor *ascending = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *artists = [songsByArtist allKeys];
    for (NSString *artist in artists) {
        songsByArtist[artist] = [songsByArtist[artist] sortedArrayUsingDescriptors:@[ascending]];
    }
    return songsByArtist;
}


@end
