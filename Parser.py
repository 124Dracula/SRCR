import pandas as pd 
import re
from math import sin, cos, sqrt, atan2, radians


def distancia (la1,lo1,la2,lo2):

	R = 6373.0

	lat1 = radians(la1)
	lon1 = radians(lo1)
	lat2 = radians(la2)
	lon2 = radians(lo2)

	dlon = lon2 - lon1
	dlat = lat2 - lat1

	a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
	c = 2 * atan2(sqrt(a), sqrt(1 - a))

	distance = R * c

	return distance*1000



dataset = pd.read_excel(r'/home/rui/Desktop/3º/SRCR/TrabalhoIndividual/dataset.xlsx')

list_Contentor_Lixo =[]
list_Contentor_Papel = []
list_Contentor_Vidro = []
list_Contentor_Embalagens = []
list_Contentor_Organico = []
dic_RuasAdjacentes = {}
dic_Rua_Contentores_Lixo = {}
dic_Rua_Contentores_Papel = {}
dic_Rua_Contentores_Vidro = {}
dic_Rua_Contentores_Embalagens = {}
dic_Rua_Contentores_Organico = {}
dic_Rua_Contentores = {}
arcos_lixo = []
arcos_papel = []
arcos_vidro = []
arcos_embalagem = []
arcos_organico = []
arcos_indiferenciados = []
estima = []



for line in dataset.values:
	flag = False
	i = 0
	if line[5] == "Lixos":
		for (x,y,_,_,_,_,_) in list_Contentor_Lixo:
			if x == line[0] and y == line[1]:
				flag = True
			++i
		if flag == True:
				l = list(list_Contentor_Lixo[i-1])
				l[6] = l[6] + int(line[9])
				p = l[2]
				t = tuple(l)
				list_Contentor_Lixo[i-1] = t
				adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
				if adjacentesTotais:
					if p in dic_RuasAdjacentes:
						if adjacentesTotais.group(1) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(1))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
						if adjacentesTotais.group(2) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(2))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
					else:
						dic_RuasAdjacentes[p] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
						print("Entrei aqui")

		else:
			ruaTotal = re.search(r':\ (.+?)(\ \(|\,)',line[4])
			rua = ruaTotal.group(1)
			list_Contentor_Lixo.append((line[0],line[1],line[2],line[3],rua,line[5],int(line[9])))
			if rua in dic_Rua_Contentores_Lixo:
				dic_Rua_Contentores_Lixo[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores_Lixo[rua] = [(line[2],line[0],line[1])]
			if rua in dic_Rua_Contentores:
				dic_Rua_Contentores[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores[rua] = [(line[2],line[0],line[1])]
			adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
			if adjacentesTotais:
				dic_RuasAdjacentes[line[2]] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
			else :
				dic_RuasAdjacentes[line[2]] =[]
			estima.append((line[2],distancia(-9.15225663484226,38.7140002169301,line[0],line[1])))

	elif line[5] == "Papel e Cartão":
		for (x,y,_,_,_,_,_) in list_Contentor_Papel:
			if x == line[0] and y == line[1]:
				flag = True
			++i
		if flag == True:
				l = list(list_Contentor_Lixo[i-1])
				l[6] = l[6] + int(line[9])
				p = l[2]
				t = tuple(l)
				list_Contentor_Lixo[i-1] = t
				adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
				if adjacentesTotais:
					if p in dic_RuasAdjacentes:
						if adjacentesTotais.group(1) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(1))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
						if adjacentesTotais.group(2) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(2))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
					else:
						dic_RuasAdjacentes[p] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
		else:
			ruaTotal = re.search(r':\ (.+?)(\ \(|\,)',line[4])
			rua = ruaTotal.group(1)
			list_Contentor_Papel.append((line[0],line[1],line[2],line[3],rua,line[5],int(line[9])))
			if rua in dic_Rua_Contentores_Papel:
				dic_Rua_Contentores_Papel[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores_Papel[rua] = [(line[2],line[0],line[1])]
			if rua in dic_Rua_Contentores:
				dic_Rua_Contentores[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores[rua] = [(line[2],line[0],line[1])]
			adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
			if adjacentesTotais:
				dic_RuasAdjacentes[line[2]] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
			else :
				dic_RuasAdjacentes[line[2]] =[]
			estima.append((line[2],distancia(-9.15225663484226,38.7140002169301,line[0],line[1])))

	elif line[5] == "Vidro":
		for (x,y,_,_,_,_,_) in list_Contentor_Vidro:
			if x == line[0] and y == line[1]:
				flag = True
			++i
		if flag == True:
				l = list(list_Contentor_Lixo[i-1])
				l[6] = l[6] + int(line[9])
				p = l[2]
				t = tuple(l)
				list_Contentor_Lixo[i-1] = t
				adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
				if adjacentesTotais:
					if p in dic_RuasAdjacentes:
						if adjacentesTotais.group(1) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(1))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
						if adjacentesTotais.group(2) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(2))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
					else:
						dic_RuasAdjacentes[p] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
		else:
			ruaTotal = re.search(r':\ (.+?)(\ \(|\,)',line[4])
			rua = ruaTotal.group(1)
			if rua in dic_Rua_Contentores_Vidro:
				dic_Rua_Contentores_Vidro[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores_Vidro[rua] = [(line[2],line[0],line[1])]
			if rua in dic_Rua_Contentores:
				dic_Rua_Contentores[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores[rua] = [(line[2],line[0],line[1])]
			list_Contentor_Vidro.append((line[0],line[1],line[2],line[3],rua,line[5],int(line[9])))
			adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
			if adjacentesTotais:
				dic_RuasAdjacentes[line[2]] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
			else :
				dic_RuasAdjacentes[line[2]] =[]
			estima.append((line[2],distancia(-9.15225663484226,38.7140002169301,line[0],line[1])))


	elif line[5] == "Embalagens":
		for (x,y,_,_,_,_,_) in list_Contentor_Embalagens:
			if x == line[0] and y == line[1]:
				flag = True
			++i
		if flag == True:
				l = list(list_Contentor_Lixo[i-1])
				l[6] = l[6] + int(line[9])
				p = l[2]
				t = tuple(l)
				list_Contentor_Lixo[i-1] = t
				adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
				if adjacentesTotais:
					if p in dic_RuasAdjacentes:
						if adjacentesTotais.group(1) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(1))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
						if adjacentesTotais.group(2) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(2))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
					else:
						dic_RuasAdjacentes[p] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
		else:
			ruaTotal = re.search(r':\ (.+?)(\ \(|\,)',line[4])
			rua = ruaTotal.group(1)
			if rua in dic_Rua_Contentores_Embalagens:
				dic_Rua_Contentores_Embalagens[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores_Embalagens[rua] = [(line[2],line[0],line[1])]
			if rua in dic_Rua_Contentores:
				dic_Rua_Contentores[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores[rua] = [(line[2],line[0],line[1])]
			list_Contentor_Embalagens.append((line[0],line[1],line[2],line[3],rua,line[5],int(line[9])))
			adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
			if adjacentesTotais:
				dic_RuasAdjacentes[line[2]] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
			else :
				dic_RuasAdjacentes[line[2]] =[]
			estima.append((line[2],distancia(-9.15225663484226,38.7140002169301,line[0],line[1])))


	elif line[5] == "Organicos":
		for (x,y,_,_,_,_,_) in list_Contentor_Organico:
			if x == line[0] and y == line[1]:
				flag = True
			++i
		if flag == True:
				l = list(list_Contentor_Lixo[i-1])
				l[6] = l[6] + int(line[9])
				p = l[2]
				t = tuple(l)
				list_Contentor_Lixo[i-1] = t
				adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
				if adjacentesTotais:
					if p in dic_RuasAdjacentes:
						if adjacentesTotais.group(1) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(1))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
						if adjacentesTotais.group(2) not in dic_RuasAdjacentes[p]:
							l = list(dic_RuasAdjacentes[p])
							l.append(adjacentesTotais.group(2))
							t = tuple(l)
							dic_RuasAdjacentes[p] = t
					else:
						dic_RuasAdjacentes[p] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
		else:
			ruaTotal = re.search(r':\ (.+?)(\ \(|\,)',line[4])
			rua = ruaTotal.group(1)
			if rua in dic_Rua_Contentores_Organico:
				dic_Rua_Contentores_Organico[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores_Organico[rua] = [(line[2],line[0],line[1])]
			if rua in dic_Rua_Contentores:
				dic_Rua_Contentores[rua].append((line[2],line[0],line[1]))
			else:
				dic_Rua_Contentores[rua] = [(line[2],line[0],line[1])]
			list_Contentor_Organico.append((line[0],line[1],line[2],line[3],rua,line[5],int(line[9])))
			adjacentesTotais = re.search(r'\)\:\ (.+?)\ \-\ (.+?)\)',line[4])
			if adjacentesTotais:
				dic_RuasAdjacentes[line[2]] = (adjacentesTotais.group(1),adjacentesTotais.group(2))
			else :
				dic_RuasAdjacentes[line[2]] =[]
			estima.append((line[2],distancia(-9.15225663484226,38.7140002169301,line[0],line[1])))


pontos = open('/home/rui/Desktop/3º/SRCR/TrabalhoIndividual/pontos.pl',"w+",encoding = 'utf-8')
teste = open('/home/rui/Desktop/3º/SRCR/TrabalhoIndividual/teste.txt',"w+",encoding = 'utf-8')

for line in list_Contentor_Lixo:
	pontos.write(f"ponto_recolha_lixo({line[0]},{line[1]},{line[2]},\"{line[3]}\",\"{line[4]}\",\"{line[5]}\",{line[6]}).\n")

for line in list_Contentor_Papel:
	pontos.write(f"ponto_recolha_papel({line[0]},{line[1]},{line[2]},\"{line[3]}\",\"{line[4]}\",\"{line[5]}\",{line[6]}).\n")

for line in list_Contentor_Vidro:
	pontos.write(f"ponto_recolha_vidro({line[0]},{line[1]},{line[2]},\"{line[3]}\",\"{line[4]}\",\"{line[5]}\",{line[6]}).\n")

for line in list_Contentor_Embalagens:
	pontos.write(f"ponto_recolha_embalagem({line[0]},{line[1]},{line[2]},\"{line[3]}\",\"{line[4]}\",\"{line[5]}\",{line[6]}).\n")

for line in list_Contentor_Organico:
	pontos.write(f"ponto_recolha_organico({line[0]},{line[1]},{line[2]},\"{line[3]}\",\"{line[4]}\",\"{line[5]}\",{line[6]}).\n")



pontos.write(f"ponto_recolha_lixo(-9.14330880914792,38.7080787857025,0,\"Misericórdia\",\"R do Alecrim\",\"Garagem\",0).\n")
pontos.write(f"ponto_recolha_papel(-9.14330880914792,38.7080787857025,0,\"Misericórdia\",\"R do Alecrim\",\"Garagem\",0).\n")
pontos.write(f"ponto_recolha_vidro(-9.14330880914792,38.7080787857025,0,\"Misericórdia\",\"R do Alecrim\",\"Garagem\",0).\n")
pontos.write(f"ponto_recolha_embalagem(-9.14330880914792,38.7080787857025,0,\"Misericórdia\",\"R do Alecrim\",\"Garagem\",0).\n")
pontos.write(f"ponto_recolha_organico(-9.14330880914792,38.7080787857025,0,\"Misericórdia\",\"R do Alecrim\",\"Garagem\",0).\n")


pontos.write(f"ponto_recolha_lixo(-9.15225663484226,38.7140002169301,1000,\"Misericórdia\",\"R Quintinha\",\"Deposito\",0).\n")
pontos.write(f"ponto_recolha_papel(-9.15225663484226,38.7140002169301,1000,\"Misericórdia\",\"R Quintinha\",\"Deposito\",0).\n")
pontos.write(f"ponto_recolha_vidro(-9.15225663484226,38.7140002169301,1000,\"Misericórdia\",\"R Quintinha\",\"Deposito\",0).\n")
pontos.write(f"ponto_recolha_embalagem(-9.15225663484226,38.7140002169301,1000,\"Misericórdia\",\"R Quintinha\",\"Deposito\",0).\n")
pontos.write(f"ponto_recolha_organico(-9.15225663484226,38.7140002169301,1000,\"Misericórdia\",\"R Quintinha\",\"Deposito\",0).\n")


# arcos entre Rua:

for key,value in dic_Rua_Contentores.items():
	size = len(value)
	i= 0
	if (size != 1):
		for i in range(size):
			if i != size-1:
				arcos_indiferenciados.append((value[i][0],value[i+1][0],distancia(value[i][1],value[i][2],value[i+1][1],value[i+1][2])))
				if i == 0:
					arcos_indiferenciados.append((0,value[i][0],distancia(-9.14330880914792,38.7080787857025,value[i][1],value[i][2])))
			else:
				arcos_indiferenciados.append((value[i][0],1000,distancia(-9.15225663484226,38.7140002169301,value[i][1],value[i][2])))
			++i



for key,value in dic_Rua_Contentores_Lixo.items():
	size = len(value)
	i= 0
	if (size != 1):
		for i in range(size):
			if i != size-1:
				arcos_lixo.append((value[i][0],value[i+1][0],distancia(value[i][1],value[i][2],value[i+1][1],value[i+1][2])))
				if i == 0:
					arcos_lixo.append((0,value[i][0],distancia(-9.14330880914792,38.7080787857025,value[i][1],value[i][2])))
			else:
				arcos_lixo.append((value[i][0],1000,distancia(-9.15225663484226,38.7140002169301,value[i][1],value[i][2])))
			++i

for key,value in dic_Rua_Contentores_Papel.items():
	size = len(value)
	i= 0
	if (size != 1):
		for i in range(size):
			if i != size-1:
				arcos_papel.append((value[i][0],value[i+1][0],distancia(value[i][1],value[i][2],value[i+1][1],value[i+1][2])))
				if i == 0:
					arcos_papel.append((0,value[i][0],distancia(-9.14330880914792,38.7080787857025,value[i][1],value[i][2])))
			else:
				arcos_papel.append((value[i][0],1000,distancia(-9.15225663484226,38.7140002169301,value[i][1],value[i][2])))
			++i

for key,value in dic_Rua_Contentores_Vidro.items():
	size = len(value)
	i= 0
	if (size != 1):
		for i in range(size):
			if i != size-1:
				arcos_vidro.append((value[i][0],value[i+1][0],distancia(value[i][1],value[i][2],value[i+1][1],value[i+1][2])))
				if i == 0:
					arcos_vidro.append((0,value[i][0],distancia(-9.14330880914792,38.7080787857025,value[i][1],value[i][2])))
			else:
				arcos_vidro.append((value[i][0],1000,distancia(-9.15225663484226,38.7140002169301,value[i][1],value[i][2])))
			++i


for key,value in dic_Rua_Contentores_Embalagens.items():
	size = len(value)
	i= 0
	if (size != 1):
		for i in range(size):
			if i != size-1:
				arcos_embalagem.append((value[i][0],value[i+1][0],distancia(value[i][1],value[i][2],value[i+1][1],value[i+1][2])))
				if i == 0:
					arcos_embalagem.append((0,value[i][0],distancia(-9.14330880914792,38.7080787857025,value[i][1],value[i][2])))
			else:
				arcos_embalagem.append((value[i][0],1000,distancia(-9.15225663484226,38.7140002169301,value[i][1],value[i][2])))
			++i

for key,value in dic_Rua_Contentores_Organico.items():
	size = len(value)
	i= 0
	if (size != 1):
		for i in range(size):
			if i != size-1:
				arcos_organico.append((value[i][0],value[i+1][0],distancia(value[i][1],value[i][2],value[i+1][1],value[i+1][2])))
				if i == 0:
					arcos_organico.append((0,value[i][0],distancia(-9.14330880914792,38.7080787857025,value[i][1],value[i][2])))
			else:
				arcos_organico.append((value[i][0],1000,distancia(-9.15225663484226,38.7140002169301,value[i][1],value[i][2])))
			++i


# arcos adjacentes 

for key,value in dic_RuasAdjacentes.items():
	for key1,value1 in dic_Rua_Contentores_Lixo.items():
		for element in value1:
			if key in element:
				(c,lat1,lon1) = element
				for ele in value:
					dis = 10000
					flag = False
					flag2 = False
					if ele in dic_Rua_Contentores_Lixo:
						for (contentor,la,lo) in dic_Rua_Contentores_Lixo[ele]:
							dis2 = distancia(lat1,lon1,la,lo)
							for item in arcos_lixo:
								if (item[0] == contentor and item[1] == c) or (item[1] == contentor and item[0] == c):
									flag2 = True
							if (dis2 < dis) and not flag2:
								dis = dis2
								aux = (contentor,la,lo)
								flag = True
					if flag and dis != 0 and not flag2:
						arcos_lixo.append((c,aux[0],dis))
						arcos_indiferenciados.append((c,aux[0],dis))
	for key1,value1 in dic_Rua_Contentores_Papel.items():
		for element in value1:
			if key in element:
				(c,lat1,lon1) = element
				for ele in value:
					dis = 10000
					flag = False
					if ele in dic_Rua_Contentores_Papel:
						for (contentor,la,lo) in dic_Rua_Contentores_Papel[ele]:
							dis2 = distancia(lat1,lon1,la,lo)
							if (dis2 < dis):
								dis = dis2
								aux = (contentor,la,lo)
								flag = True
					if flag and dis != 0:
						arcos_papel.append((c,aux[0],dis))
						arcos_indiferenciados.append((c,aux[0],dis))
	
	for key1,value1 in dic_Rua_Contentores_Vidro.items():
		for element in value1:
			if key in element:
				(c,lat1,lon1) = element
				for ele in value:
					dis = 10000
					flag = False
					if ele in dic_Rua_Contentores_Vidro:
						for (contentor,la,lo) in dic_Rua_Contentores_Vidro[ele]:
							dis2 = distancia(lat1,lon1,la,lo)
							if (dis2 < dis):
								dis = dis2
								aux = (contentor,la,lo)
								flag = True
					if flag and dis != 0:
						arcos_vidro.append((c,aux[0],dis))
						arcos_indiferenciados.append((c,aux[0],dis))
	for key1,value1 in dic_Rua_Contentores_Embalagens.items():
		for element in value1:
			if key in element:
				(c,lat1,lon1) = element
				for ele in value:
					dis = 10000
					flag = False
					if ele in dic_Rua_Contentores_Embalagens:
						for (contentor,la,lo) in dic_Rua_Contentores_Embalagens[ele]:
							dis2 = distancia(lat1,lon1,la,lo)
							if (dis2 < dis):
								dis = dis2
								aux = (contentor,la,lo)
								flag = True
					if flag and dis != 0:
						arcos_embalagem.append((c,aux[0],dis))
						arcos_indiferenciados.append((c,aux[0],dis))	
	for key1,value1 in dic_Rua_Contentores_Organico.items():
		for element in value1:
			if key in element:
				(c,lat1,lon1) = element
				for ele in value:
					dis = 10000
					flag = False
					if ele in dic_Rua_Contentores_Organico:
						for (contentor,la,lo) in dic_Rua_Contentores_Organico[ele]:
							dis2 = distancia(lat1,lon1,la,lo)
							if (dis2 < dis):
								dis = dis2
								aux = (contentor,la,lo)
								flag = True
					if flag and dis != 0:
						arcos_organico.append((c,aux[0],dis))
						arcos_indiferenciados.append((c,aux[0],dis))

arcos = open('/home/rui/Desktop/3º/SRCR/TrabalhoIndividual/arcos.pl',"w+",encoding = 'utf-8')

arcos_lixo.append((1000,0,distancia(-9.14330880914792,38.7080787857025,-9.15225663484226,38.7140002169301)))
arcos_papel.append((1000,0,distancia(-9.14330880914792,38.7080787857025,-9.15225663484226,38.7140002169301)))
arcos_vidro.append((1000,0,distancia(-9.14330880914792,38.7080787857025,-9.15225663484226,38.7140002169301)))
arcos_embalagem.append((1000,0,distancia(-9.14330880914792,38.7080787857025,-9.15225663484226,38.7140002169301)))
arcos_organico.append((1000,0,distancia(-9.14330880914792,38.7080787857025,-9.15225663484226,38.7140002169301)))
arcos_indiferenciados.append((1000,0,distancia(-9.14330880914792,38.7080787857025,-9.15225663484226,38.7140002169301)))


estima.append((0,distancia(-9.14330880914792,38.7080787857025,-9.15225663484226,38.7140002169301)))
estima.append((1000,0.0))

for line in arcos_lixo:
	arcos.write(f"arcos_lixo({line[0]},{line[1]},{line[2]}).\n")

for line in arcos_papel:
	arcos.write(f"arcos_papel({line[0]},{line[1]},{line[2]}).\n")

for line in arcos_vidro:
	arcos.write(f"arcos_vidro({line[0]},{line[1]},{line[2]}).\n")

for line in arcos_embalagem:
	arcos.write(f"arcos_embalagem({line[0]},{line[1]},{line[2]}).\n")

for line in arcos_organico:
	arcos.write(f"arcos_organico({line[0]},{line[1]},{line[2]}).\n")

for line in arcos_indiferenciados:
	arcos.write(f"arcos_indiferenciados({line[0]},{line[1]},{line[2]}).\n")
	
estimas = open('/home/rui/Desktop/3º/SRCR/TrabalhoIndividual/estimas.pl',"w+",encoding = 'utf-8')

for line in estima:
	estimas.write(f"estima({line[0]},{line[1]}).\n")
