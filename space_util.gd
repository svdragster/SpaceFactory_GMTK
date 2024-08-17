extends Node


static func format_int(number: int) -> String:
	var n := str(number)
	var size := n.length()
	var s := ""
	
	for i in range(size):
			if((size - i) % 3 == 0 and i > 0):
				s = str(s,",", n[i])
			else:
				s = str(s,n[i])
			
	return s
