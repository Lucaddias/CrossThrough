// CXDragView — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001013c
// -[CXDragView draggingEntered:]
    return 0x1;


// 0x100010144
// -[CXDragView performDragOperation:]
    r20 = [arg2 retain];
    r0 = [self delegate];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [r0 performDragOperation:r20];
    [r20 release];
    [r19 release];
    r0 = r21;
    return r0;


// 0x1000101a8
// -[CXDragView delegate]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_delegate)), 0x1);
    return r0;


// 0x1000101b8
// -[CXDragView setDelegate:]
    objc_setProperty_atomic();
    return;


// 0x1000101c4
// -[CXDragView .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_delegate, 0x0);
    return;


