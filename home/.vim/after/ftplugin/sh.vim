let l = getline(0, 1)
if 2 > len(l) && l[0] =~ '\s*'
	call append(0, '')
	call append(0, '#!/bin/sh')
endif
