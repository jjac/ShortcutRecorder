//
//  Copyright 2012 ShortcutRecorder Contributors
//  CC BY 4.0
//

#import "ShortcutRecorder/SRKeyCodeTransformer.h"
#import "ShortcutRecorder/SRRecorderControl.h"

#import "ShortcutRecorder/SRKeyEquivalentModifierMaskTransformer.h"


@implementation SRKeyEquivalentModifierMaskTransformer

#pragma mark Methods

+ (instancetype)sharedTransformer
{
    static dispatch_once_t OnceToken;
    static SRKeyEquivalentModifierMaskTransformer *Transformer = nil;
    dispatch_once(&OnceToken, ^{
        Transformer = [SRKeyEquivalentModifierMaskTransformer new];
    });
    return Transformer;
}

#pragma mark NSValueTransformer

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

+ (Class)transformedValueClass
{
    return NSNumber.class;
}

- (NSNumber *)transformedValue:(NSDictionary *)aValue
{
    if (![aValue isKindOfClass:NSDictionary.class] && ![aValue isKindOfClass:SRShortcut.class])
        return [NSNumber numberWithInteger:0];

    NSNumber *modifierFlags = aValue[SRShortcutKeyModifierFlags];

    if (![modifierFlags isKindOfClass:NSNumber.class])
        return nil;

    return modifierFlags;
}

@end
