#!/usr/bin/python
import math
import pdb

##SCRIPT TO GENERATE CELLS FOR A CITY


def createHexFromCoord(lat,lon):
	d=100.0 #Hexagon radius
	earthR = 6371 #Earth radius
	dR = d/earthR #Angular distance (in radians)

	bearing1=90*math.pi/180 #Bearing (each number for each transition)
	bearing2=30*math.pi/180
	bearing3=330*math.pi/180
	bearing4=270*math.pi/180
	bearing5=210*math.pi/180
	bearing6=90*math.pi/180

	newLat1 = math.asin( math.sin(lat)*math.cos(dR) + math.cos(lat)*math.sin(dR)*math.cos(bearing1))
	newLon1 = lon + math.atan2(math.sin(bearing1)*math.sin(dR)*math.cos(lat), math.cos(dR)-math.sin(lat)*math.sin(newLat1))

	newLat2 = math.asin( math.sin(newLat1)*math.cos(dR) + math.cos(newLat1)*math.sin(dR)*math.cos(bearing2))
	newLon2 = newLon1 + math.atan2(math.sin(bearing2)*math.sin(dR)*math.cos(newLat1), math.cos(dR)-math.sin(newLat1)*math.sin(newLat2))

	newLat3 = math.asin( math.sin(newLat2)*math.cos(dR) + math.cos(newLat2)*math.sin(dR)*math.cos(bearing3))
	newLon3 = newLon2 + math.atan2(math.sin(bearing3)*math.sin(dR)*math.cos(newLat2), math.cos(dR)-math.sin(newLat2)*math.sin(newLat3))

	newLat4 = math.asin( math.sin(newLat3)*math.cos(dR) + math.cos(newLat3)*math.sin(dR)*math.cos(bearing4))
	newLon4 = newLon3 + math.atan2(math.sin(bearing4)*math.sin(dR)*math.cos(newLat3), math.cos(dR)-math.sin(newLat3)*math.sin(newLat4))

	newLat5 = math.asin( math.sin(newLat4)*math.cos(dR) + math.cos(newLat4)*math.sin(dR)*math.cos(bearing5))
	newLon5 = newLon4 + math.atan2(math.sin(bearing5)*math.sin(dR)*math.cos(newLat4), math.cos(dR)-math.sin(newLat4)*math.sin(newLat5))

	#hex center
	newLat6 = math.asin( math.sin(newLat5)*math.cos(dR) + math.cos(newLat5)*math.sin(dR)*math.cos(bearing6))
	newLon6 = newLon5 + math.atan2(math.sin(bearing6)*math.sin(dR)*math.cos(newLat5), math.cos(dR)-math.sin(newLat5)*math.sin(newLat6))

	nextPointLat = newLat5
	nextPointLon = newLon5
	


	return [
			{"lat":newLat6*180/math.pi,"lon":newLon6*180/math.pi},  #center
			{"lat":lat*180/math.pi,"lon":lon*180/math.pi},			#first point
			{"lat":newLat1*180/math.pi,"lon":newLon1*180/math.pi},
			{"lat":newLat2*180/math.pi,"lon":newLon2*180/math.pi},
			{"lat":newLat3*180/math.pi,"lon":newLon3*180/math.pi},
			{"lat":newLat4*180/math.pi,"lon":newLon4*180/math.pi},
			{"lat":newLat5*180/math.pi,"lon":newLon5*180/math.pi}
			],nextPointLat,nextPointLon


#lat=(53+19.0/60+14.0/3600)*math.pi/180
#lon=(1+43.0/60+47.0/3600)*math.pi/180

maxLat = 51.713124
maxLon = 0.212173
minLat = 51.416191
minLon = -0.608368

#First hex

nextPointLon = -0.608368*math.pi/180
nextPointLat = 51.416191*math.pi/180


nextOriginLat =  51.416191*math.pi/180
nextOriginLon = -0.608368*math.pi/180

par=0

i=0
j=0

while (i<10):
	i+=1
	##Longitud (horizontal)
	firstTime = 1
	nextPointLat = nextOriginLat
	nextPointLon = nextOriginLon
	if nextOriginLon>maxLon: break
	while (j<10):
		j+=1
		##Latitud (vertical)
		r,nextPointLat,nextPointLon = createHexFromCoord(nextPointLat,nextPointLon)
		print r
		if firstTime:
			if not par:
				nextOriginLat = r[3]["lat"] 
				nextOriginLon = r[3]["lon"]
				par = 1
			else:
				d=100.0 #Hexagon radius
				earthR = 6371 #Earth radius
				dR = d/earthR #Angular distance (in radians)
				bearing1=150*math.pi/180 #Bearing (each number for each transition)
				newLat1 = math.asin( math.sin(r[2]["lat"])*math.cos(dR) + math.cos(r[2]["lat"])*math.sin(dR)*math.cos(bearing1))
				newLon1 = r[2]["lon"] + math.atan2(math.sin(bearing1)*math.sin(dR)*math.cos(r[2]["lat"]), math.cos(dR)-math.sin(r[2]["lat"])*math.sin(newLat1))
				nextOriginLat = newLat1
				nextOriginLon = newLon1
				par = 0
			firstTime = 0
		if nextPointLat>maxLat: break
