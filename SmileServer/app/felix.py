################################

##### FELIX THE CATGORITHM #####
#####     ALPHA 0.0.1      #####

################################

from app import db
from models import *

def generateCellParametersForCellId(cellId):
    """

    :param cellId:
    :return:
    """
    cell = Cell.query.filter_by(id=cellId).first()
    datas = Data.query.filter_by(cell = cell).all()

    security = 0
    securityTotal = 0

    environment = 0
    environmentTotal = 0

    cultural = 0
    culturalTotal = 0

    services = 0
    servicesTotal = 0

    opinion = 0
    opinionTotal = 0

    for data in datas:
        if data.dataType == "Museos":
            culturalTotal += 1
            cultural += int(data.dataValue)
        if data.dataType == "SportsCenters":
            culturalTotal += 1
            cultural += int(data.dataValue)

        if data.dataType == "Librerias":
            culturalTotal += 1
            cultural += int(data.dataValue)

        if data.dataType == "Teatros":
            culturalTotal += 1
            cultural += int(data.dataValue)

        if data.dataType == "TouristAttractions":
            culturalTotal += 1
            cultural += int(data.dataValue)

        if data.dataType == "LocalesOcio":
            culturalTotal += 1
            cultural += int(data.dataValue)

        if data.dataType == "Parques":
            environmentTotal += 1
            environment += int(data.dataValue)

        if data.dataType == "Huertas":
            environmentTotal += 1
            environment += int(data.dataValue)

        if data.dataType == "HuellaEcológica":
            environmentTotal += 1
            environment += int(data.dataValue)

        if data.dataType == "CO2Emissions":
            environmentTotal += 1
            environment += int(data.dataValue)

        if data.dataType == "Arboles":
            environmentTotal += 1
            environment += int(data.dataValue)

        if data.dataType == "ContaminacionRuido":
            environmentTotal += 1
            environment += int(data.dataValue)

        if data.dataType == "HappySurveis":
            opinionTotal += 1
            opinion += int(data.dataValue)

        if data.dataType == "Robos":
            securityTotal += 1
            security += int(data.dataValue)

        if data.dataType == "Incencios":
            securityTotal += 1
            security += int(data.dataValue)

        if data.dataType == "CrimeRatio":
            securityTotal += 1
            security += int(data.dataValue)

        if data.dataType == "PublicToilets":
            servicesTotal += 1
            services += int(data.dataValue)

        if data.dataType == "Schools":
            servicesTotal += 1
            services += int(data.dataValue)

        if data.dataType == "SuicideRate":
            servicesTotal += 1
            services += int(data.dataValue)

        if data.dataType == "Hospitales":
            servicesTotal += 1
            services += int(data.dataValue)

        if data.dataType == "HealthCenters":
            servicesTotal += 1
            services += int(data.dataValue)

        if data.dataType == "CentrosEducativos":
            servicesTotal += 1
            services += int(data.dataValue)

        if data.dataType == "RailwayStation":
            servicesTotal += 1
            services += int(data.dataValue)



    return cultural/culturalTotal, environment/environmentTotal, security/securityTotal, services/servicesTotal, opinion/opinionTotal



def importDataFromExternalApisForCity(cityId):
    pass


def updateOpinionForCell(cellId,newOpinion):
    pass
