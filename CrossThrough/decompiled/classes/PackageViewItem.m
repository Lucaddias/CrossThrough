// PackageViewItem — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003a744
// -[PackageViewItem init]
    var_10 = self;
    r0 = [[&var_10 super] initWithNibName:@"PackageViewItem" bundle:0x0];
    return r0;


// 0x10003a784
// -[PackageViewItem dividerLine]
    r0 = objc_loadWeakRetained((int64_t *)&self->_dividerLine);
    r0 = [r0 autorelease];
    return r0;


// 0x10003a7a4
// -[PackageViewItem setDividerLine:]
    objc_storeWeak((int64_t *)&self->_dividerLine, arg2);
    return;


// 0x10003a7b8
// -[PackageViewItem .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_dividerLine);
    return;


