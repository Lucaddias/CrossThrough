// IconCollectionView — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100041b6c
// -[IconCollectionView acceptsFirstResponder]
    return 0x1;


// 0x100041b74
// -[IconCollectionView becomeFirstResponder]
    [self setIsFirstResponder:0x1];
    return 0x1;


// 0x100041b90
// -[IconCollectionView resignFirstResponder]
    [self setIsFirstResponder:0x0];
    return 0x1;


// 0x100041bac
// -[IconCollectionView keyDown:]
    r20 = [arg2 retain];
    r0 = [self nextResponder];
    r0 = [r0 retain];
    r19 = r0;
    [r0 keyDown:r20];
    [r20 release];
    [r19 release];
    return;


// 0x100041bfc
// -[IconCollectionView mouseDown:]
    var_30 = self;
    r21 = [arg2 retain];
    [[&var_30 super] mouseDown:r21];
    r0 = [self nextResponder];
    r0 = [r0 retain];
    r19 = r0;
    [r0 mouseDown:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100041c84
// -[IconCollectionView isFirstResponder]
    r0 = *(int8_t *)(int64_t *)&self->_isFirstResponder & 0x1;
    return r0;


// 0x100041c98
// -[IconCollectionView setIsFirstResponder:]
    *(int8_t *)(int64_t *)&self->_isFirstResponder = arg2;
    return;


