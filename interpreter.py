import sys

lines = open(sys.argv[1]).readlines()
lines = [line.strip() for line in lines]
lines = [line.split(" ") for line in lines]
lines = [[line[0]] + [int(x) for x in line[1:]] for line in lines]

addr = 0
mem = [0 for i in range(1024)]
regs = [0 for i in range(16)]
debug = int(sys.argv[2])


def add():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] + regs[lines[addr][3]]
	addr += 1

def mul():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] * regs[lines[addr][3]]
	addr += 1

def sou():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] - regs[lines[addr][3]]
	addr += 1

def div():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] / regs[lines[addr][3]]
	addr += 1

def afc():
	global addr
	regs[lines[addr][1]] = lines[addr][2]
	addr += 1

def load():
	global addr
	regs[lines[addr][1]] = mem[lines[addr][2]]
	addr += 1

def store():
	global addr
	mem[lines[addr][1]] = regs[lines[addr][2]]
	addr += 1

def supegal():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] >= regs[lines[addr][3]]
	addr += 1

def sup():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] > regs[lines[addr][3]]
	addr += 1

def infegal():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] <= regs[lines[addr][3]]
	addr += 1

def inf():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] < regs[lines[addr][3]]
	addr += 1

def egal():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] == regs[lines[addr][3]]
	addr += 1

def diff():
	global addr
	regs[lines[addr][1]] = regs[lines[addr][2]] != regs[lines[addr][3]]
	addr += 1

def jmpc():
	global addr
	if(regs[lines[addr][2]] == 0):
		addr = lines[addr][1]
	else:
		addr += 1

def jmp():
	global addr
	addr = lines[addr][1]


op = {	'ADD' : add, 'AFC' : afc, 'STORE' : store, 'LOAD' : load, 
		'MUL' : mul, 'DIV' : div, 'SOU' : sou,
		'SUPEGAL' : supegal,'SUP' : sup, 'INFEGAL' : infegal, 'INF' : inf,
		'EGAL' : egal, 'DIFF' : diff, "JMPC" : jmpc, "JMP" : jmp}
	
#print(lines)

while addr < len(lines):
	if debug:
		print(lines[addr][0], end="\t")
		if (addr+1) % 10 == 0: 
			print()
	if lines[addr][0] in op:
		op[lines[addr][0]]()
	elif debug:
		print("err: " + str(mem[addr]) + " " + lines[addr][0])
		#exit(3)
		break
print("\n")
for i in range(len(regs)):
	print("R@%x: %.2f" % (i, regs[i]))
print()
for i in range(16):
	print("M@%d: %.2f" % (127 + i, mem[127 + i]))
