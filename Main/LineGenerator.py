import random

def generateLines(**options):
	
	num = random.randint(4,11)
	if options.get("nums"):
		num = options.get("nums")
	
	content = '' + str(num) + '\n';
	
	for i in range(num):
		x1 = random.randint(0,800)
		x2 = random.randint(0,800)
		y1 = random.randint(0,400)
		y2 = random.randint(0,400)
		content += '{},{},{},{}'.format(x1,x2,y1,y2)
		if i != num-1:
			content += '\n'

	return content

def generateFiles(num):
	filename = 'lines'
	filetpye = '.in'
	segment = list()
	for i in range(5):
		file = open(filename + str(i+1) + filetpye,'w')
		file.write(generateLines())


def main():
	# num = input("Please input number of files that you wana generate")
	num = 2
	generateFiles(num)

if __name__ == '__main__':
	main()