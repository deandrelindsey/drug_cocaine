['coca_leaf'] = {
    label = 'Coca Leaf',
    weight = 200,
    stack = true,
    description = 'Raw coca leaf'
},

['coca_paste'] = {
    label = 'Coca Paste',
    weight = 100,
    stack = true,
    description = 'Intermediate form of cocaine'
},

['cocaine_powder'] = {
    label = 'Cocaine (Powder)',
    weight = 75,
    stack = true,
    description = 'Snortable cocaine',
    client = {
        export = 'drug_cocaine:use',
        event = 'drug_cocaine:use',
        args = { 'powder' }
    }
},

['cocaine_crack'] = {
    label = 'Crack Cocaine',
    weight = 50,
    stack = true,
    description = 'Highly addictive crack',
    client = {
        export = 'drug_cocaine:use',
        event = 'drug_cocaine:use',
        args = { 'crack' }
    }
},

['cocaine_fishscale'] = {
    label = 'Colombian Fishscale',
    weight = 60,
    stack = true,
    description = 'High purity cocaine',
    client = {
        export = 'drug_cocaine:use',
        event = 'drug_cocaine:use',
        args = { 'fishscale' }
    }
}
